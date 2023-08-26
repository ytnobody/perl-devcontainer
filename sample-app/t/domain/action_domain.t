use v5.36;
use Test2::V0;
use Test2::Tools::Subtest qw(subtest_buffered);

my $module = 'MyToDoApp::Domain::ActionDomain';
use ok 'MyToDoApp::Domain::ActionDomain';

subtest_buffered build_action => sub {
  my $task_id = 1;
  my $created_at = 	1693011473;
  my $updated_at = 	1693011480;
  my $action = $module->build_action($task_id, 'description', $created_at, $updated_at);
  is($action, {
    task_id     => $task_id,
    description => 'description',
    created_at  => $created_at,
    updated_at  => $updated_at,
  }, 'build action');
};

subtest_buffered insert_query => sub {
  my $task_id = 1;
  my $created_at = 	1693011473;
  my $updated_at = 	1693011480;
  my $action = $module->build_action($task_id, 'description', $created_at, $updated_at);
  my $query = [$module->insert_query($action)];
  is($query, ['insert', 'action', $action], 'insert query');
};

subtest_buffered get_by_id_query => sub {
  my $query = [$module->get_by_id_query(1)];
  is($query, ['single', 'action', {id => 1}]);
};

subtest_buffered select_by_task_id_query => sub {
  my $query = [$module->select_by_task_id_query(1)];
  is($query, ['select', 'action', {task_id => 1}]);
};

done_testing;