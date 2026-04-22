# Executive Conclusions: Frog Habitat & Environmental Sensitivity Analysis

This document summarizes the outcomes of the Frog Habitat analysis, mapping the three core analytical goals to their respective methodologies, quantitative results, and actionable conservation strategies.

---

## 🎯 Goal 1: Establish the Ideal Habitat Profile

### How We Achieved It
We performed a baseline descriptive statistical analysis comparing the geographical and climatic conditions of locations where frogs are present versus where they are absent. We focused on medians, overall distributions, and outlier detection to avoid skewing from extreme environmental anomalies.

### Key Results
The data revealed that physical geography dominates local climate in determining habitability. 
* **Geography First:** The median distance to a water source for viable habitats is 500m, compared to 1,500m for non-viable locations—a massive 1,000m difference. 
* **Breeding Infrastructure:** Viable habitats possess a statistically higher median number of pools (21 vs. 16).
* **Climate Baselines:** Climate metrics showed only slight preferences (e.g., +0.6°C for Min Temperature) and negligible differences in average rainfall. Furthermore, extreme maximum outliers in the dataset predominantly belonged to locations devoid of frogs.

### Recommended Actions
Field expeditions should target specific global regions that match our ideal baseline (Altitude ~1,500m, Distance < 500m, Pools 21+, Midpoint Temp ~8.6°C+). 
By cross-referencing these metrics with Cfb/Cfc and BWk global climate zones, we recommend prioritizing three prime lake district locations for future conservation efforts:
1. **The Central Highlands of Tasmania**
2. **The Patagonian Andean Lake District (Argentina)**
3. **The South Island High Country (New Zealand)**

---

## 🎯 Goal 2: Assess Climate vs. Geography Drivers

### How We Achieved It
To transition from descriptive observations to rigorous mathematical proof, we utilized a two-step validation framework:
1. **SQL Cohort Analysis:** Using `NTILE` window functions, we binned the dataset into three equal-sized cohorts to evaluate the "Win Rate" (probability of presence) without sample-size bias.
2. **Statistical Validation (Python):** We ran non-parametric Mann-Whitney U-tests on the un-binned data to calculate precise P-Values for each feature, given the non-normal distribution of geographical metrics.

### Key Results
The hypothesis testing perfectly mirrored the SQL cohorts, definitively rejecting the Null Hypothesis for key geographical metrics while failing to reject it for volatile climate metrics.
* **Highly Significant Drivers (p < 0.001):** Distance to Water ($1.03 \times 10^{-11}$), Midpoint Temperature ($5.33 \times 10^{-6}$), and Altitude ($3.42 \times 10^{-5}$). 
* **The Distance Cliff:** Habitats further than 900m from water see a catastrophic drop in presence rates (down to 16.2%).
* **The Thermal Baseline:** Habitability triples as the average baseline temperature rises from 6.8°C to 10.2°C.
* **Insignificant Drivers:** Average Rainfall (p=0.908) and Temperature Swings (p=0.426) proved statistically irrelevant to predicting frog presence.

### Recommended Actions
Conservation site selection must follow a **Three-Tier Prioritization Strategy**:
* **Tier 1 (Non-Negotiables):** Strict enforcement of Distance (< 500m), Altitude (~1,500m), and Midpoint Temperature (> 8.6°C). Compromising here nullifies habitability.
* **Tier 2 (Optimizations):** Maximize the number of pools. If land meets Tier 1 criteria but lacks pools, conservation funds should be actively diverted to artificially digging breeding pools to boost viability.
* **Tier 3 (Flexible Variables):** Researchers should exploit the statistical insignificance of rainfall and temperature volatility to radically expand their potential geographic search radius.

---

## 🎯 Goal 3: Predictive Probability Modeling

### How We Achieved It
We constructed a predictive machine learning framework to approximate exact probabilities for incoming field data. 
* **Classical Modeling:** We built a custom Logistic Regression model via Maximum Likelihood Estimation (MLE), engineering a mean-centered quadratic feature $(Temp - Mean)^2$ to mathematically enforce the biological "Goldilocks Zone" of temperature tolerance.
* **Non-Linear Manifold Learning:** We evaluated advanced dimensionality reduction (UMAP, t-SNE, Kernel PCA) paired with downstream SVMs to map complex, overlapping ecological clusters.

### Key Results
* **Statistical Certainty:** The handcrafted polynomial regression generated highly reliable 95% and 99% confidence intervals using the Fisher Information Matrix, proving near-certain presence under optimal conditions.
* **The Analytics Champion:** **t-SNE (Perplexity 65) + RBF SVM** achieved the absolute peak theoretical accuracy (**82.08%**) and the highest recall (**68%**), successfully mapping continuous environmental gradients without artificially shattering the data.
* **The Deployment Reality:** Because t-SNE lacks a native `.transform()` method for live inference, the slightly less accurate but mathematically scalable **UMAP (10, 0.001) + Logistic Regression** pipeline (**80.66% accuracy**) was identified as the production-ready standard. 

### Recommended Actions
To operationalize these mathematical models, we recommend moving away from static reporting and utilizing real-time inference tools.
* **Deploy Interactive Dashboards:** Field researchers should utilize the deployed cloud environments (Binders) to dynamically calculate habitat viability *before* committing physical funds to an expedition. 
* **Use the Dual-Pipeline Approach:** Rely on the fast, raw regression dashboard for quick mathematical point-estimates in the field, and utilize the UMAP + Logistic Regression dashboard for complex, scaled manifold predictions against the historical database.

**Binder 1: The Raw Statistical Regression Model** *(Fast, purely mathematical point-estimates utilizing our handcrafted Maximum Likelihood formula).*
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Rent45/Frog-Data-Analysis/main?urlpath=%2Fdoc%2Ftree%2Fbinder%2FRegression_Binder.ipynb)

**Bunder 2: The Non-Linear Machine Learning Pipeline** *(Advanced inference utilizing the deployed 9D PCA + SVM and UMAP + Logistic Regression models).*
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/Rent45/Frog-Data-Analysis/main?urlpath=%2Fdoc%2Ftree%2Fbinder%2FPCA_Binder.ipynb)
