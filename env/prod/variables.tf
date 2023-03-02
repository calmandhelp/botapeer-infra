variable "access_key" {
  description = "アクセスキー"
}
variable "secret_key" {
  description = "シークレットキー"
}
variable "environment" {
  default     = "prod"
  description = "環境を表す変数"
}
variable "service_name" {
  default     = "botapeer"
  description = "サービス名"
}