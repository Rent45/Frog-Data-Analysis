### Dimensionality Reduction: Executive Summary

After evaluating three non-linear manifold learning techniques, UMAP was selected as the foundational architecture for the inference pipeline.

| Technique | Core Mechanism | Deployment Ready (`.transform`) | Downstream Accuracy | Verdict |
| :--- | :--- | :--- | :--- | :--- |
| **Kernel PCA (RBF)** | Calculates variance in high-dimensional feature space using kernel tricks. | ✅ Yes | **73.58%** | A strong mathematical baseline, but lacks the topological flexibility to untangle highly complex ecological overlaps. |
| **t-SNE** | Minimizes KL divergence to preserve local neighborhood geometries. | ❌ No (Requires full dataset refit) | **76.89%** | Excellent for exploratory visual analysis (identifying micro-clusters), but fundamentally unsuited for live production pipelines. |
| **UMAP** | Uses Riemannian geometry to preserve both local clusters and global topological structure. | ✅ Yes | **80.66%** | **The Best.** Achieved peak linear separability while maintaining the ability to map incoming live telemetry data. |
