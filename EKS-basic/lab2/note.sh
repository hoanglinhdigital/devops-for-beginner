TODO Remove below policy:

"Condition": {
    "Null": {
        "aws:RequestTag/elbv2.k8s.aws/cluster": "true",
        "aws:ResourceTag/elbv2.k8s.aws/cluster": "false"
    }
}