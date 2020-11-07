#!/usr/bin/env bash

helm repo update
helm install reloader stakater/reloader
k create namespace cert-manager
k label ns cert-manager certmanager.k8s.io/disable-validation="true"
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.1/cert-manager.yaml
helm install cert-manager --namespace cert-manager jetstack/cert-manager --set webhook.enabled=false
k delete mutatingwebhookconfigurations.admissionregistration.k8s.io cert-manager-webhook
k delete validatingwebhookconfigurations.admissionregistration.k8s.io cert-manager-webhook

