class TODO {
  var id;
  var date;
  var task;

  TODO( {this.id
 ,
   this.date, this.task});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"date": this.date, "taskName": this.task};
    return map;
  }
}