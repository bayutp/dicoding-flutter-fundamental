enum RestaurantWorkmanager {
  oneoff("task-identifier", "task-identifier"),
  periodic("com.dicoding.notificationApp", "com.dicoding.notificationApp");

  final String uniqueName;
  final String taskName;

  const RestaurantWorkmanager(this.uniqueName, this.taskName);
}
