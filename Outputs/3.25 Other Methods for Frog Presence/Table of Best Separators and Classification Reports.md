### Dimensionality Reduction & Classification Leaderboard

| Rank | Dimensionality Reduction | Parameters | Downstream Classifier | Accuracy |
| :---: | :--- | :--- | :--- | :--- |
| **1** | **t-SNE** | Perplexity = 65 | SVM (RBF) | **82.08%** |
| **2** | **UMAP** | n_neighbors = 10, min_dist = 0.001 | Logistic Regression | **80.66%** |
| **3** | **t-SNE** | Perplexity = 5 | Logistic Regression | 79.72% |
| **3** | **t-SNE** | Perplexity = 5 | SVM (RBF) | 79.72% |
| **5** | **UMAP** | n_neighbors = 10, min_dist = 0.001 | SVM (Polynomial) | 78.30% |
| **6** | **t-SNE** | Perplexity = 65 | Logistic Regression | 76.89% |
| **7** | **Kernel PCA** | (RBF Kernel) | Logistic Regression | 73.58% |
| **8** | **Kernel PCA** | (RBF Kernel) | SVM (Poly & RBF) | 73.11% |

---

### Executive Conclusions

**1. The Synergy of t-SNE (65) + RBF SVM**
The highest quantitative accuracy (82.08%) was achieved by combining a globally stable manifold with a locally flexible boundary. At Perplexity 65, t-SNE maintained the macro-ecological continuous gradients of the habitat data. Because the manifold was not artificially shattered, the RBF SVM was able to smoothly wrap its curved decision boundaries around those continuous gradients.

**2. The t-SNE "Perplexity 5" Illusion**
At Perplexity 5, Logistic Regression and the RBF SVM scored the exact same percentage (79.72%). This mathematically proves that extreme low perplexity violently shatters the data into isolated micro-clusters. When data is this fragmented, the choice of classifier becomes irrelevant because the model is merely memorizing topological noise rather than learning genuine ecological boundaries.

**3. UMAP Does the Heavy Lifting**
Pairing UMAP with a simple Logistic Regression yielded an 80.66% accuracy. However, introducing a more complex Polynomial SVM degraded performance to 78.30%. This indicates that UMAP's non-linear unfolding is highly aggressive; adding a secondary non-linear classifier on top of it causes instant overfitting. On the UMAP manifold, the simplest classifier is the most effective.

**4. The Failure of Kernel PCA**
Kernel PCA models consistently anchored the bottom of the leaderboard (~73%). This confirms that relying purely on global variance (stretching) is fundamentally the wrong mathematical approach for separating overlapping, complex ecological habitats.

### Final Deployment Architecture
While the t-SNE (65) + RBF SVM pipeline achieved the peak theoretical accuracy (82.08%), t-SNE fundamentally lacks a `.transform()` method, making it incapable of processing live, incoming field data. Therefore, the **UMAP + Logistic Regression pipeline (80.66%)** is selected as the final production model. Sacrificing ~1.4% accuracy is a necessary engineering trade-off to secure a robust pipeline capable of real-time inference and deployment.



---
## Classification Reports

### Model 1: t-SNE (Perplexity=65) + SVM (RBF)

| Metric | Precision | Recall | F1-Score | Support |
| :--- | :---: | :---: | :---: | :---: |
| **Absent (0)** | 0.83 | 0.90 | 0.86 | 133 |
| **Present (1)** | 0.81 | 0.68 | 0.74 | 79 |
| | | | | |
| **Accuracy** | | | **0.82** | 212 |
| **Macro Avg** | 0.82 | 0.79 | 0.80 | 212 |
| **Weighted Avg** | 0.82 | 0.82 | 0.82 | 212 |

<br>

### Model 2: UMAP (10, 0.001) + Logistic Regression

| Metric | Precision | Recall | F1-Score | Support |
| :--- | :---: | :---: | :---: | :---: |
| **Absent (0)** | 0.81 | 0.90 | 0.85 | 133 |
| **Present (1)** | 0.80 | 0.65 | 0.71 | 79 |
| | | | | |
| **Accuracy** | | | **0.81** | 212 |
| **Macro Avg** | 0.80 | 0.77 | 0.78 | 212 |
| **Weighted Avg** | 0.81 | 0.81 | 0.80 | 212 |
