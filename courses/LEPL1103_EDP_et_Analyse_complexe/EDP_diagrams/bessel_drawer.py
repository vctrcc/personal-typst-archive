import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # noqa: F401 (needed for 3D)
from scipy.special import j0, y0, jn_zeros
from scipy.optimize import brentq

# ============================================================
# Parameters you can tweak
# ============================================================
R_disk = 1.0      # radius of the full disk

R_in = 0.4        # inner radius of ring
R_out = 1.0       # outer radius of ring

n_r = 200
n_theta = 200

# How many modes to search / allow
num_disk_modes = 4        # number of disk radial modes we precompute
disk_mode_index = 2       # 0=fundamental, 1=next, 2=more oscillations, ...

num_ring_modes_search = 8 # how many annulus modes we look for
ring_mode_index = 2       # 0=fundamental, 1=next, 2=more oscillations, ...

# ============================================================
# Angular grid
# ============================================================
theta = np.linspace(0, 2 * np.pi, n_theta)

# ============================================================
# 1) Disk domain + eigenmode (axisymmetric, m=0)
# ============================================================
r_disk = np.linspace(0, R_disk, n_r)
R_disk_grid, Theta_disk_grid = np.meshgrid(r_disk, theta)

X_disk = R_disk_grid * np.cos(Theta_disk_grid)
Y_disk = R_disk_grid * np.sin(Theta_disk_grid)

# Get first num_disk_modes zeros of J0
zeros_J0 = jn_zeros(0, num_disk_modes)  # zeros of J0(x)

if disk_mode_index >= num_disk_modes:
    raise ValueError(
        f"disk_mode_index={disk_mode_index} is too large; "
        f"only {num_disk_modes} modes precomputed."
    )

# For a disk of radius R_disk, we need k_n such that J0(k_n * R_disk) = 0
# i.e. k_n * R_disk = zeros_J0[n] -> k_n = zeros_J0[n] / R_disk
k_disk = zeros_J0[disk_mode_index] / R_disk

# Axisymmetric eigenfunction: u(r) = J0(k r)
Z_disk = j0(k_disk * R_disk_grid)

# Normalize amplitude for pretty plotting
Z_disk /= np.max(np.abs(Z_disk))

# ============================================================
# 2) Annulus (ring) domain + eigenmode (axisymmetric, m=0)
# ============================================================
r_ring = np.linspace(R_in, R_out, n_r)
R_ring_grid, Theta_ring_grid = np.meshgrid(r_ring, theta)

X_ring = R_ring_grid * np.cos(Theta_ring_grid)
Y_ring = R_ring_grid * np.sin(Theta_ring_grid)

# For the annulus we use:
# u(r) = A J0(alpha r) + B Y0(alpha r)
# and enforce u(R_in) = 0 and u(R_out) = 0
#
# This leads to the determinant condition:
# F(alpha) = J0(alpha R_in) Y0(alpha R_out) - Y0(alpha R_in) J0(alpha R_out) = 0

def F(alpha):
    return j0(alpha * R_in) * y0(alpha * R_out) - y0(alpha * R_in) * j0(alpha * R_out)

# --- Find several roots of F(alpha) by scanning and bracketing ---
max_alpha = 60.0
num_alpha_samples = 20000
alphas = np.linspace(0.1, max_alpha, num_alpha_samples)  # start at 0.1 to avoid Y0(0) singularity
F_vals = F(alphas)

# Find indices where sign changes: F[i] * F[i+1] < 0
sign_changes = np.where(np.diff(np.sign(F_vals)) != 0)[0]

if len(sign_changes) == 0:
    raise RuntimeError("No root of F(alpha) found in the search range.")

if ring_mode_index >= min(num_ring_modes_search, len(sign_changes)):
    raise ValueError(
        f"ring_mode_index={ring_mode_index} is too large; "
        f"only {len(sign_changes)} modes detected (limit {num_ring_modes_search})."
    )

# We'll refine up to num_ring_modes_search roots (or as many as we found)
root_indices_to_use = sign_changes[:num_ring_modes_search]

alphas_roots = []
for idx in root_indices_to_use:
    a_left = alphas[idx]
    a_right = alphas[idx + 1]
    root = brentq(F, a_left, a_right)
    alphas_roots.append(root)

alpha_chosen = alphas_roots[ring_mode_index]

# Now construct the annulus eigenmode:
# One convenient form that automatically satisfies u(R_in)=0 is
# u(r) = Y0(alpha R_in) J0(alpha r) - J0(alpha R_in) Y0(alpha r)
def annulus_mode(r):
    return (
        y0(alpha_chosen * R_in) * j0(alpha_chosen * r)
        - j0(alpha_chosen * R_in) * y0(alpha_chosen * r)
    )

Z_ring = annulus_mode(R_ring_grid)

# Normalize amplitude
Z_ring /= np.max(np.abs(Z_ring))

# ============================================================
# Plotting
# ============================================================
# --- Disk plot ---
fig1 = plt.figure()
ax1 = fig1.add_subplot(111, projection='3d')
ax1.plot_surface(X_disk, Y_disk, Z_disk / 2.5, cmap='viridis', linewidth=0, antialiased=False)
ax1.set_title(f"Disk eigenmode (m=0, radial index={disk_mode_index})")
ax1.set_xlabel("x")
ax1.set_ylabel("y")
ax1.set_zlabel("u(r)")
ax1.set_zlim(-1, 1)

fname1 = f"disk_eigenmode_m0_radialidx_{disk_mode_index}.png"
fig1.savefig(fname1, dpi=300, bbox_inches='tight')
print(f"Saved {fname1}")
plt.close(fig1)

# --- Ring (annulus) plot ---
fig2 = plt.figure()
ax2 = fig2.add_subplot(111, projection='3d')
ax2.plot_surface(X_ring, Y_ring, Z_ring / 4, cmap='viridis', linewidth=0, antialiased=False)
ax2.set_title(f"Annulus eigenmode (m=0, radial index={ring_mode_index})")
ax2.set_xlabel("x")
ax2.set_ylabel("y")
ax2.set_zlabel("u(r)")
ax2.set_zlim(-1, 1)

fname2 = f"annulus_eigenmode_m0_radialidx_{ring_mode_index}.png"
fig2.savefig(fname2, dpi=300, bbox_inches='tight')
print(f"Saved {fname2}")
plt.close(fig2)
