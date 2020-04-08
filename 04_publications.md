---
layout: page
title: publications
permalink: /pubs/
---

<!-- ## projects -->
<!-- ![Pdflogo](/assets/pdflogo.png) -->


<!-- # Transverse arch foot stiffness
Should talk about the work done so far, as well as the proposed modulation work.
void readAcc(void)
{
  Wire.beginTransmission(IMU_ADDRESS);
  Wire.write(LSM6::OUTX_L_XL);
  Wire.endTransmission();
  Wire.requestFrom(IMU_ADDRESS, (uint8_t)6);

  uint8_t xla = Wire.read();
  uint8_t xha = Wire.read();
  uint8_t yla = Wire.read();
  uint8_t yha = Wire.read();
  uint8_t zla = Wire.read();
  uint8_t zha = Wire.read();

  // combine high and low bytes
  ax = (int16_t)(xha << 8 | xla);
  ay = (int16_t)(yha << 8 | yla);
  az = (int16_t)(zha << 8 | zla);

  
  Wire.beginTransmission(IMU_ADDRESS);
  Wire.write(LSM6::OUTX_L_G);
  Wire.endTransmission();
  Wire.requestFrom(IMU_ADDRESS, (uint8_t)6);

  uint8_t xlg = Wire.read();
  uint8_t xhg = Wire.read();
  uint8_t ylg = Wire.read();
  uint8_t yhg = Wire.read();
  uint8_t zlg = Wire.read();
  uint8_t zhg = Wire.read();

  // combine high and low bytes
  gx = (int16_t)(xhg << 8 | xlg);
  gy = (int16_t)(yhg << 8 | ylg);
  gz = (int16_t)(zhg << 8 | zlg);
  
  angle = atan2(az, ax) * 57.296; // convert radians to degrees
  angledot = gy/29;
  Serial.print(" omega_y = ");
  Serial.println(angledot);
  
}
# Surface curvature articulation
Blah

# Variable stiffness joint
Blah

# Soap films and drops 
Blah -->
## journal articles
+ **Stiffness of the human foot and evolution of the transverse arch.** Venkadesan M, Yawar A, Eng CM, Dias MA, Singh DK, Tommasini S, Haims A, Bandi MM, Mandre S. (2020).  *Nature*, 579 (7797), 97–100. [Full text](https://rdcu.be/b2dCo){:target="blank"}
+ **Contribution of the transverse arch to foot stiffness in humans.** Yawar, A., Korpas, L., Lugo-Bolanos, M., Mandre, S. and Venkadesan, M., 2017. [arXiv preprint](https://arxiv.org/pdf/1706.04610.pdf){:target="blank"}
+ On angled bounce-off impact of a drop impinging on a flowing soap film Basu, S., Yawar, A., Concha, A., and Bandi, M.M. *Fluid Dynamics Research* **49** 065509 2017 [![Download pdf](/assets/pdflogo.png)](../assets/basu2017.pdf){:target="blank"} (Winner of the [Fluid Dynamics Research Prize, 2018](https://iopscience.iop.org/journal/1873-7005/page/Awards){:target="blank"})

## conference presentations
+ **Curvature-induced stiffness in mechanical mimics of the human foot.** Yawar, A., Mandre, S., Venkadesan, M. (2019) In Proceedings of the 9th International Symposium on Adaptive Motion of Animals and Machines, Lausanne, Switzerland
+ **Quantifying the role of the windlass mechanism in increasing foot stiffness.** Yawar, A., Eng, C.M. and Tommasini, S. and Venkadesan, M. (2019) In Proc. of the 28th Congress of the Int. Soc. of Biomechanics and the 43rd Annual Meeting of the Am. Soc. of Biomechanics, Calgary, Canada
+ **Contribution of the transverse arch to foot stiffness.** Yawar, A., Korpas, L., Lugo-Bolanos, M., Mandre, S. and Venkadesan, M. (2018) In Dynamic Walking Pensacola FL, USA
+ **To move or not: principal curvatures of articular surfaces.** Sharma, N., Yawar, A., Bhullar, B.A.S., Venkadesan, M. (2018) In Integrative and Comparative Biology
+ **Bending-stretching coupling in the human foot: Role of the transverse arch.** Yawar, A., Korpas, L.M., Lugo-Bolanos, M., Mandre, S. and Venkadesan, M. (2017)  In Integrative and Comparative Biology (Vol. 57, pp. E451-E451)
+ **Stiffness of the Arched Human Foot.** Yawar, A., Korpas, L.M., Lugo-Bolanos, M., Mandre, S. and Venkadesan, M. (2016) In Society for Industrial and Applied Mathematics Annual Meeting, Boston MA, USA
+ **Experimental study of drop impacts on soap films.** Yawar, A., Basu, S., Concha, A. and Bandi, M.M. (2015) In APS Meeting Abstracts, APS-DFD 2015 Boston, MA, USA