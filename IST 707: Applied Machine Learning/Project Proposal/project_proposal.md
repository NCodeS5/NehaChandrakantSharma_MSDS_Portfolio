# Enhancing Radiological Diagnoses through Pattern Imaging Analytics

## Team
- Akshay Joshi
- Akash Sapkal
- Dhruv Shah
- Harshil Rathod
- Mariya Zubair Mansuri
- Neha Sharma

## Introduction
The goal of our efforts is to effectively recognize tiny patterns indicative of various health conditions in medical imaging, hence improving radiological diagnoses through the application of machine learning techniques. Through the analysis of radiographic imaging datasets such as the National Institutes of Health Clinical Center's dataset, our goal is to create sophisticated algorithms that can identify early indicators of abnormalities in organs such as the brain, lungs, and breasts. Our method combines segmentation and pattern recognition techniques to improve illness tracking and improve diagnostic accuracy.

## Objectives
- Train deep learning models for pattern detection in radiography pictures using the National Institutes of Health Clinical Center's dataset.
- Put pattern segmentation strategies into practice to facilitate quicker disease progression tracking and diagnosis.
- Assess the accuracy, sensitivity, specificity, and clinical utility of the model's performance.
- Investigate the integration of multimodal data, such as clinical notes or patient demographics, with radiography images to enrich diagnostic insights and enhance model performance.

## Literature Review
In current radiological practices, diagnoses heavily rely on human observation and interpretation of medical images, primarily chest x-rays. However, this approach is inherently subjective and susceptible to errors, variability, and oversights, leading to potential diagnostic inaccuracies and delays in patient care. Despite advancements in medical imaging technology, the interpretation of these images remains a complex task, often requiring specialized expertise and extensive training. Machine learning techniques have emerged as promising tools to aid radiologists in image analysis, offering the potential to improve diagnostic accuracy and efficiency.

However, existing machine learning approaches still face challenges in accurately identifying subtle patterns indicative of diseases, particularly in the context of chest x-ray interpretation. While some studies have explored the application of machine learning algorithms in medical imaging, there remains a gap in achieving consistently reliable diagnoses. Our project aims to address this gap by leveraging advanced machine learning algorithms and comprehensive datasets, such as the recently released NIH Clinical Center chest x-ray dataset, to enhance radiological diagnoses. By combining novel machine learning methodologies with rich and diverse datasets, we seek to develop a robust and reliable framework for automated chest x-ray interpretation, ultimately improving patient outcomes and advancing the field of radiology.

## Stakeholders
Stakeholders for a project can vary depending on the specific context, goals, and scope of the project. Here's a list of potential stakeholders:

1. **Medical Professionals**: Radiologists, physicians, and other healthcare professionals involved in diagnosing medical conditions using radiological imaging. They are the primary users and beneficiaries of the enhanced diagnostic capabilities.

2. **Patients**: Individuals who undergo radiological imaging for medical diagnosis and treatment. They are the ultimate recipients of accurate and timely diagnoses, which can impact their treatment plans and outcomes.

3. **Healthcare Institutions**: Hospitals, clinics, and medical centers where radiological imaging services are provided. These institutions may invest in and implement the technology to improve diagnostic accuracy, patient care, and operational efficiency.

4. **IT and Data Science Teams**: Professionals responsible for developing, implementing, and maintaining the pattern imaging analytics technology. This includes data scientists, software engineers, and IT specialists who design and deploy the algorithms and infrastructure for image analysis.

5. **Regulatory Bodies**: Government agencies and regulatory bodies responsible for overseeing healthcare practices and ensuring compliance with standards and regulations related to medical imaging, patient privacy, and data security.

6. **Healthcare Administrators**: Hospital administrators, department heads, and decision-makers responsible for budgeting, resource allocation, and strategic planning. They may be involved in evaluating the cost-effectiveness and potential impact of implementing the new technology.

7. **Research Institutions**: Academic institutions, research organizations, and industry partners involved in conducting research and development related to pattern imaging analytics, machine learning algorithms, and medical imaging technology.

8. **Insurance Providers**: Insurance companies and payers who may have an interest in the project's outcomes, especially if the technology can lead to more accurate diagnoses, reduced treatment costs, and improved patient outcomes.

9. **Ethics Committees**: Committees responsible for reviewing and approving research projects involving human subjects, ensuring that ethical standards and patient rights are upheld throughout the project.
    
10. **Community and Patient Advocacy Groups**: Organizations representing the interests of patients and advocating for access to quality healthcare services. They may provide input on the project's design, implementation, and potential impact on patient care and outcomes.


## Data and Methods
### Data
The National Institutes of Health Clinical Center has recently made available over 100,000 anonymized chest x-ray images and associated data to the scientific community. This extensive dataset, sourced from more than 30,000 patients, provides a valuable resource for researchers worldwide, facilitating the development of machine learning algorithms for disease detection and diagnosis. Prior to release, the dataset underwent meticulous screening to ensure the removal of personally identifiable information, upholding patient privacy standards. 

Despite the apparent simplicity of interpreting chest x-ray images, the process involves intricate reasoning and necessitates knowledge spanning anatomy, physiology, and pathology. The initiative aims to empower researchers to teach computers to interpret chest x-rays accurately, augmenting radiologists' diagnostic capabilities and potentially uncovering overlooked findings. 

Data Examples: 

<img width="180" alt="image" src="https://github.com/IST407-707/project-checkpoint-1-llama-bots/assets/78223679/2f9033ab-2408-4aa2-ab46-d65c17fe3d81"> <img width="180" alt="image" src="https://github.com/IST407-707/project-checkpoint-1-llama-bots/assets/78223679/1bca8cbe-4dd8-4cbf-8f25-7164101b8d42"> <img width="180" alt="image" src="https://github.com/IST407-707/project-checkpoint-1-llama-bots/assets/78223679/b0260187-a7de-44b4-89e0-27ea33a218b2">




Data Links:

https://nihcc.box.com/shared/static/vfk49d74nhbxq3nqjg0900w5nvkorp5c.gz,
https://nihcc.box.com/shared/static/i28rlmbvmfjbl8p2n3ril0pptcmcu9d1.gz,
https://nihcc.box.com/shared/static/f1t00wrtdk94satdfb9olcolqx20z2jp.gz,
https://nihcc.box.com/shared/static/0aowwzs5lhjrceb3qp67ahp0rd1l1etg.gz,
https://nihcc.box.com/shared/static/v5e3goj22zr6h8tzualxfsqlqaygfbsn.gz,
https://nihcc.box.com/shared/static/asi7ikud9jwnkrnkj99jnpfkjdes7l6l.gz,
https://nihcc.box.com/shared/static/jn1b4mw4n6lnh74ovmcjb8y48h8xj07n.gz,
https://nihcc.box.com/shared/static/tvpxmn7qyrgl0w8wfh9kqfjskv6nmm1j.gz,
https://nihcc.box.com/shared/static/upyy3ml7qdumlgk2rfcvlb9k6gvqq2pj.gz,
https://nihcc.box.com/shared/static/l6nilvfa9cg3s28tqv1qc1olm3gnz54p.gz,
https://nihcc.box.com/shared/static/hhq8fkdgvcari67vfhs7ppg2w6ni4jze.gz,
https://nihcc.box.com/shared/static/ioqwiy20ihqwyr8pf4c24eazhh281pbu.gz

### Methods
To ensure consistency and quality in our diagnostic process, a data preprocessing strategy will be implemented as a fundamental aspect of our modeling approach. Data preprocessing encompasses techniques such as normalization, image resizing, noise reduction, and data augmentation, which serve to standardize the data, eliminate noise, and enhance the signal-to-noise ratio, thereby enhancing the performance of our deep learning models.

Following data preprocessing, the next step involves experimentation with various deep learning architectures, including recurrent neural networks (RNNs) and convolutional neural networks (CNNs). RNNs are adept at sequential data analysis, making them suitable for tasks like time-series analysis or sequential pattern recognition, which are pertinent in radiological image analysis. Conversely, CNNs excel at capturing spatial patterns in images, making them well-suited for tasks such as image classification and object detection.

Through exploration of these diverse architectures, the objective is to develop models capable of accurately identifying patterns in medical images indicative of various illnesses or abnormalities. These models will undergo training using a sizable dataset of labeled radiological images, enabling them to discern complex patterns and correlations between image features and clinical outcomes.

The performance evaluation of our models will employ industry-standard measures such as accuracy, precision, recall, and F1-score. Additionally, expert evaluations will be conducted wherein radiologists and medical professionals will assess the clinical value of the models. This evaluation process entails comparing the model predictions with the ground truth diagnoses provided by experienced radiologists.

Integration of expert evaluations into our model assessment process ensures that our models not only achieve high performance metrics but also demonstrate clinical relevance and utility in real-world healthcare settings. This iterative approach, encompassing experimentation, evaluation, and refinement, aims to develop highly effective diagnostic tools that assist medical professionals in making accurate and timely diagnoses, thereby enhancing patient outcomes and healthcare delivery.

## Project Plan (Tentative)
| Period | Activity | Milestone |
|--------|----------|-----------|
| 3/12-3/19 | Data Collection and Preprocessing | Dataset compiled and preprocessed |
| 3/19-3/26 | Model development and training | Initial models trained and evaluated |
| 3/26-4/9 | Model refinement and validation | Refined models with validation |
| 4/9-4/23 | Integration and testing | Integration into radiology workflow tested |

## Risks
1. **Data Availability and Quality:** The National Institutes of Health Clinical Center dataset's dependability and quality must be guaranteed to build a model. By carrying out stringent data cleansing and validation procedures, we will mitigate this risk.
   
2. **Model Overfitting:** There's a chance to create extremely complicated models that might not translate well to new data. We'll use strategies like regularization and cross-validation to reduce this risk.
   
3. **Clinical Relevance:** Depending on the particular healthcare setting, our models' clinical usefulness may differ. To make sure that our models meet clinical requirements and standards, we will conduct thorough research to avoid any discrepancies.

## References
1. Irvin, Jeremy, et al. "CheXpert: A large chest radiograph dataset with uncertainty labels and expert comparison." Proceedings of the AAAI Conference on Artificial Intelligence. Vol. 33. 2019.
2. Tim, Philip, et al. (2023). Interactive and Explainable Region-guided Radiology Report Generation. arXiv:2304.08295
