%ROC for ANFIS%
threshold = 0.5;

TrainData.BinaryTargets = TrainData.TargetsDeNormal >= threshold;
TrainData.BinaryOutputs = TrainData.ANFISOutputsDeNormal >= threshold;

TestData.BinaryTargets = TestData.TargetsDeNormal >= threshold;
TestData.BinaryOutputs = TestData.ANFISOutputsDeNormal >= threshold;
% ROC Curve for Training Data
[TrainFPR, TrainTPR, TrainThresholds, TrainAUC] = perfcurve(TrainData.BinaryTargets, TrainData.ANFISOutputsDeNormal, 1);

% ROC Curve for Test Data
[TestFPR, TestTPR, TestThresholds, TestAUC] = perfcurve(TestData.BinaryTargets, TestData.ANFISOutputsDeNormal, 1);

% Plot ROC Curve for Training Data
figure;
plot(TrainFPR, TrainTPR, 'b-', 'LineWidth', 2);
hold on;
plot([0 1], [0 1], 'k--');
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title(['ROC Curve for Training Data (AUC = ' num2str(TrainAUC) ')']);
hold off;

% Plot ROC Curve for Test Data
figure;
plot(TestFPR, TestTPR, 'r-', 'LineWidth', 2);
hold on;
plot([0 1], [0 1], 'k--');
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title(['ROC Curve for Test Data (AUC = ' num2str(TestAUC) ')']);
hold off;
ResultsTrain.AUC = TrainAUC;
ResultsTest.AUC = TestAUC;
