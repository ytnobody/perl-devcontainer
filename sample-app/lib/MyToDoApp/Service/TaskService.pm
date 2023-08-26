package MyToDoApp::Service::TaskService;
use v5.36;
use Types::Standard -types;
use Function::Parameters;

use MyToDoApp::Types qw(Task);

use aliased 'MyToDoApp::Infra::Database';
use aliased 'MyToDoApp::Domain::TaskDomain';

fun add ($class, Str $title, Str $description) {
  my $time = time;
  my $task = TaskDomain->build_task($title, $description, $time, $time);

  Database->execute(
    TaskDomain->insert_query($task)
  );

  my $id = Database->last_insert_id;
  my $row = $class->get_by_id($id);
  return $row;
}

fun get_all ($class) {
  my @rows = Database->execute(
    TaskDomain->select_all_query()
  );
  return @rows;
}

fun update ($class, Int $id, Str $title, Str $description) {
  my $task = $class->get_by_id($id);
  if (!$task) {
    die "Task not found";
  }
  my $updated = TaskDomain->build_task($title, $description, $task->{created_at}, time);
  Database->execute(
    TaskDomain->update_query($id, $updated)
  );
}

fun get_by_id ($class, Int $id) {
  Database->execute(
    TaskDomain->get_by_id_query($id)  
  );
}

fun as_done ($class, Int $id) {
  my $task = $class->get_by_id($id);
  if (!$task) {
    die "Task not found";
  }
  if ($task->{done} == 1) {
    die "Task already done";
  }

  Database->execute(
    TaskDomain->as_done_query($id, time)
  );
  my $row = $class->get_by_id($id);
  return $row;
}

fun delete ($class, Int $id) {
  Database->execute(
    TaskDomain->delete_query($id)
  );
}

1;