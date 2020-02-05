# Rehabilitation-Assessment-through-Dimensionality-Reduction-and-Statistical-Modeling
The codes are based on a paper that proposes a method for evaluation of the consistency of human movements within the context of physical therapy and rehabilitation. Captured movement data in the form of joint angular displacements in a skeletal human model is considered in this work. The proposed approach employs an autoencoder neural network to project the high-dimensional motion trajectories into a low-dimensional manifold. Afterwards, a Gaussian mixture model is used to derive a parametric probabilistic model of the density of the movements. The resulting probabilistic model is employed for evaluation of the consistency of unseen motion sequences based on the likelihood of the data being drawn from the model.

The movement data is related to the Standing Shoulder Abduction exercise from the UI-PRMD dataset (University of Idaho – Physical Rehabilitation Movements Dataset). The data comprise angular joint displacements collected with a Vicon optical tracker.

For a detailed description of the files in the folder please see the List of Files and Functions document.
