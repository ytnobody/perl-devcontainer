package MyToDoApp::Service::ActionService;
use v5.36;
use MyToDoApp::Types qw(Action);
use Types::Standard -types;
use Function::Parameters;

use aliased 'MyToDoApp::Domain::ActionDomain';

use aliased 'MyToDoApp::Infra::Database';

fun add ($class, Int $task_id, Str $description) {
  my $action = ActionDomain->build_action($task_id, $description, time, time);
  
  Database->execute(
    ActionDomain->insert_query($action)
  );
  
  my $id = Database->last_insert_id;

  my $row = Database->execute(
    ActionDomain->get_by_id_query($id)
  );
  
  return $row;
}

fun get_by_task_id ($class, Int $task_id) {
  my @rows = Database->execute(
    ActionDomain->select_by_task_id_query($task_id)
  );
  return @rows;
}

fun get_by_id ($class, Int $id) {
  Database->execute(
    ActionDomain->get_by_id_query($id)
  );
}

1;