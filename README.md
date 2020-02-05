# Rehabilitation-Assessment-through-Dimensionality-Reduction-and-Statistical-Modeling
The codes are based on a method for evaluation of the consistency of human movements within the context of physical therapy and rehabilitation. Captured movement data in the form of joint angular displacements in a skeletal human model are considered in this work. The proposed approach employs an autoencoder neural network to project the high-dimensional motion trajectories into a low-dimensional manifold. Afterwards, a Gaussian mixture model is used to derive a parametric probabilistic model of the density of the movements. The resulting probabilistic model is employed for evaluation of the consistency of unseen motion sequences based on the likelihood of the data being drawn from the model.

The method is described in the above paper Williams et al (2019).

The movement data is related to the Standing Shoulder Abduction exercise from the <a href="https://www.webpages.uidaho.edu/ui-prmd/">UI-PRMD dataset</a> (University of Idaho – Physical Rehabilitation Movements Dataset). The data comprise angular joint displacements collected with a Vicon optical tracker.

Modifying the codes for data collected with the Kinect sensor or other motion capture sensors is straightforward. 

For a detailed description of the files in the repository please see the List of Files and Functions document.

# Citation
If you use the codes or the methods in your work, please cite the following article:   

   @ARTICLE{Williams2019,
   title={Assessment of Physical Rehabilitation Movements Through Dimensionality Reduction and Statistical Modeling},
   author={Williams, C. and Vakanski, A. and Lee, S. and Paul, D.},
   journal={Medical Engineering and Physics}, 
   year={2019},
   month={Dec.},
   volume={74},
   pages={13-22},
   }

# License
MIT License

# Acknowledgments
This work was supported by the <a href="https://imci.uidaho.edu/get-involved/about-cmci/">Institute for Modeling Collaboration and Innovation (IMCI)</a> at the University of Idaho through NIH Award #P20GM104420.
