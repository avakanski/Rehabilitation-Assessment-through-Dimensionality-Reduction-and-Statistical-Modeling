# Rehabilitation-Assessment-through-Dimensionality-Reduction-and-Statistical-Modeling
The codes are based on a method for evaluation of the consistency of human movements within the context of physical therapy and rehabilitation. Captured movement data in the form of joint angular displacements in a skeletal human model are considered in this work. The proposed approach employs an autoencoder neural network to project the high-dimensional motion trajectories into a low-dimensional manifold. Afterwards, a Gaussian mixture model is used to derive a parametric probabilistic model of the density of the movements. The resulting probabilistic model is employed for evaluation of the consistency of unseen motion sequences based on the likelihood of the data being drawn from the model.

The method is described in the above paper <a href="Williams et al (2019) - Rehabilitation Assessment through Statistical Modeling.pdf">Williams et al (2019)</a>.

The movement data is related to the Standing Shoulder Abduction exercise from the <a href="https://www.webpages.uidaho.edu/ui-prmd/">UI-PRMD dataset</a> (University of Idaho – Physical Rehabilitation Movements Dataset). The data comprise angular joint displacements collected with a Vicon optical tracker.

Modifying the codes for data collected with the Kinect sensor or other motion capture sensors is straightforward. 

For a detailed description of the files in the repository please see the List of Files and Functions document.

# Use
* Run "Prepare_Data_for_NN" to read the movements data, and perform pre-processing steps, such as length alignment and centering. Alternatively, skip this step, the outputs are saved in the Data folder (Data_Correct.csv and Data_Incorrect.csv).
* Run "Autoencoder_Movements" to reduce the dimensionality of the movement data. Alternatively, skip this step, the outputs are saved in the Data folder (Autoencoder_output_correct.csv and Autoencoder_output_incorrect.csv).
* Run "GMM_Performance_Indicators" to generate quality scores for the individual movement repetitions.

# Citation
If you use the codes or the methods in your work, please cite the following <a href="https://www.sciencedirect.com/science/article/abs/pii/S1350453319302127?via%3Dihub">article</a>:   

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
<a href="License - MIT.txt">MIT License</a>

# Acknowledgments
This work was supported by the <a href="https://imci.uidaho.edu/get-involved/about-cmci/">Institute for Modeling Collaboration and Innovation (IMCI)</a> at the University of Idaho through NIH Award #P20GM104420.

# Contact or Questions
<a href="https://www.webpages.uidaho.edu/vakanski/">A. Vakanski</a>, e-mail: vakanski at uidaho.edu.
