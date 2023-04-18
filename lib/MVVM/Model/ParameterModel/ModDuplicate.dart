class ParModDuplicate {
  String? Pr_EmailID;
  int? Pr_Operation;

  ParModDuplicate({
    this.Pr_EmailID,
    this.Pr_Operation,
  });

  Map<String, dynamic> toJson() {
    return {
      'Pr_EmailID': Pr_EmailID,
      'Pr_Operation': Pr_Operation,
    };
  }

}
