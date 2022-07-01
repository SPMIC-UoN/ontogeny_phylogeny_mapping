# baby-xtract

Citation:

S. Warrington, E. Thompson, M. Bastiani, J. Dubois, L. Baxter, R. Slater, S. Jbabdi, R. B. Mars, S. N. Sotiropoulos, "Concurrent mapping of brain ontogeny and phylogeny within a common space: standardised tractography and applications"

microstructure_analysis.ipynb: Jupyter Notebook for neonatal tract maturation (Figure 3). Requires numpy, pandas, seaborn, matplotlib, statsmodels and openpyxl.

blueprint_mapping.ipynb: Jupyter Notebook for connectivity blueprint mapping across ontogeny and phylogeny. Requires numpy, pandas, seaborn, matplotlib, nibabel, scipy, surfplot, adjustText and subprocess

dataset_comparison.ipynb: inter-subject variability for dHCP and Oxford datasets. Requires numpy, pandas, seaborn, matplotlib, nibabel, scipy, random and glob.

bootstrapping.ipynb: for bootstrapped ontogeny/phylogeny divergence maps (110 iterations over group-averaged subsets)

entropy_maps.ipynb: for individual and group-averaged entropy maps

entropy_divergence_corr_scripts: for spatially local (moving window) entropy-divergence correlations

Data: contains microstructure measures, tract correlations, group-averaged connectivity blueprints and cortical atlases
Surfs: surfaces for viewing macaque, neonate and adult data
Results: contains results from notebook analysis
