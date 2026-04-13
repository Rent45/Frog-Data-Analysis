### Final Habitat Prediction Model

**Site Parameters:** 500m Distance | 9.5°C Temp | 1500m Altitude

#### Mathematical Engine
The final probability ($p$) is calculated using the unscaled parameter estimates pushed through the Logistic Sigmoid function:

$$ \Large p = \frac{1}{1 + e^{-(-149.1691 - 0.0007(\text{Distance}) + 8.3080(\text{Temp Mid}) + 0.0514(\text{Altitude}))}}$$

#### Statistical Summary

| Feature | Estimate | 90% CI | 95% CI | 99% CI |
| :--- | :---: | :---: | :---: | :---: |
| **Probability** | **99.86%** | [ 95.29%, 100.00%] | [ 91.11%, 100.00%] | [ 73.06%, 100.00%] |
| Intercept | -149.1691 | [-235.6545, -62.6838] | [-252.2155, -46.1228] | [-284.6015, -13.7368] |
| Distance | -0.0007 | [ -0.0009, -0.0004] | [ -0.0010, -0.0003] | [ -0.0011, -0.0002] |
| Temp_Mid | 8.3080 | [ 3.6578, 12.9581] | [ 2.7674, 13.8486] | [ 1.0261, 15.5899] |
| Altitude | 0.0514 | [ 0.0208, 0.0820] | [ 0.0150, 0.0879] | [ 0.0035, 0.0993] |
