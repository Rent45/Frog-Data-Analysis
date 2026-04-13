### Final Habitat Prediction Model (Polynomial Logistic Regression)

**Site Parameters:** 500m Distance | 10.0°C Temp | 1500m Altitude

#### Mathematical Engine
The final probability ($p$) is calculated using the unscaled parameter estimates pushed through the Logistic Sigmoid function. The temperature term includes a mean-centered quadratic feature to mathematically model the biological "Goldilocks Zone":

$$p = \frac{1}{1 + e^{-(-117.5187 - 0.0007(\text{Distance}) + 6.9139(\text{Temp Mid}) - 0.6628(\text{Temp Mid} - \text{Mean})^2 + 0.0388(\text{Altitude}))}}$$

#### Statistical Summary

| Feature | Estimate | 90% CI | 95% CI | 99% CI |
| :--- | :---: | :---: | :---: | :---: |
| **Probability** | **99.96%** | [ 85.07%, 100.00%] | [ 64.12%, 100.00%] | [ 15.62%, 100.00%] |
| Intercept | -117.5187 | [-204.6209, -30.4164] | [-221.3000, -13.7373] | [-253.9170, 18.8797] |
| Distance | -0.0007 | [ -0.0009, -0.0004] | [ -0.0010, -0.0003] | [ -0.0011, -0.0002] |
| Temp_Mid | 6.9139 | [ 2.2770, 11.5508] | [ 1.3891, 12.4387] | [ -0.3473, 14.1751] |
| Temp_Mid_Sq | -0.6628 | [ -1.1136, -0.2120] | [ -1.1999, -0.1257] | [ -1.3687, 0.0431] |
| Altitude | 0.0388 | [ 0.0077, 0.0699] | [ 0.0018, 0.0758] | [ -0.0099, 0.0875] |
