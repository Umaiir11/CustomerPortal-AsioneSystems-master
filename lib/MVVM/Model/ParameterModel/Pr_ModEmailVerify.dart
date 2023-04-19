class Pr_ModVerifyEmail {
  String? Pr_EmailTo;
  String? Pr_Subject;
  String? Pr_Body;
  String? Pr_Confirmation;

  Pr_ModVerifyEmail({
    this.Pr_EmailTo,
    this.Pr_Subject,
    this.Pr_Body,
    this.Pr_Confirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'Pr_EmailTo': Pr_EmailTo,
      'Pr_Subject': Pr_Subject,
      'Pr_Body': Pr_Body,
      'Pr_Confirmation': Pr_Confirmation,
    };
  }
}
