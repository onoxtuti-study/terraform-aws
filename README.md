# terraform + aws + GitHubActions ポートフォリオ
## 概要
Terraformを使用してAWS上にリソースの構築。なお、構築するにあたりGitHubActionsを使用して簡易的なCI/CDを作成
- VPC
- Subnet
- InternetGateway (IGW)
- RouteTable (RT)
- EC2 on Al2023 (SSH接続確認済み)
- SecurityGroup (SG)
- tfstateは環境(STG/PRD)ごとにS3バケットで管理 ※排他制御は未実施
- 秘匿情報はGit管理から除外しS3バケットで管理

## 使用技術
- Terraform v1.12.2
- AWS provider v6.4.0
- GitHub
- GitHubActions

## STGデプロイ手順
1. ローカルでfeatuerブランチを作成
2. 変更/追加/削除作業実施
3. リモートリポジトリへfeatureブランチをpush
4. developブランチへPR作成
5. ソース構成の妥当性チェック + フォーマットを最適化 (CI)
6. developブランチへマージ
7. STG環境へリリース (CD)

## PRDデプロイ手順
1. mainブランチへdevelopブランチからのPRを作成
2. ソース構成の妥当性チェック + フォーマットを最適化 (CI)
3. mainブランチへマージ
4. PRD環境へリリース (CD)

## AWSの認証情報について
- GitHub Secretsで運用

## 今後の拡張予定
- GitHubActionsを使用しランナーにAnsibleを導入
  (AnsibleでMWの管理予定)

## 備考
- EC2で使用するKeyPairについては、変更回数およびセキュリティの観点からTerraformの管理外
- SSH接続はローカルMacからインターネット経由で確認済み (鍵情報はリポジトリに含まれておりません)
- SGは私しの自宅からの22 portのみ解放 (必要に応じて穴開けを実施予定)
  
## 参考文献
- 【入門】Terraformの基礎を90分で解説するチュートリアル (https://www.youtube.com/watch?v=h1MDCp7blmg)
- GitHub Actionsを使ってCI/CDを実装！ジョブを自動化して開発効率UP！ (https://www.youtube.com/watch?v=RxcUrg3OO3o&t=29s)
- ChatGpt (https://chatgpt.com/)
- 【第1回】Ansibleを学ぼう。Ansibleとは？ (https://www.youtube.com/watch?v=NtNbMYkoG7w)
- 【第2回】Ansibleを学ぼう。Ansibleとは②？ (https://www.youtube.com/watch?v=5greKorNULA)
- 【第3回】Ansibleを学ぼう。Ansibleの概要 (https://www.youtube.com/watch?v=JCfJa_hwo2o)
