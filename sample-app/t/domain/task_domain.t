use v5.36;
use Test2::V0;
use Test2::Tools::Subtest qw(subtest_buffered);

my $module = 'MyToDoApp::Domain::TaskDomain';
use ok 'MyToDoApp::Domain::TaskDomain';

subtest_buffered build_task => sub {
  my $created_at = 	1693011473;
  my $updated_at = 	1693011480;
  my $task = $module->build_task('title', 'description', $created_at, $updated_at);
  is($task, {
    title       => 'title',
    description => 'description',
    created_at  => $created_at,
    updated_at  => $updated_at,
    done        => 0,
  }, 'build task');
};

subtest_buffered build_task_detail => sub {
  my $created_at = 	1693011473;
  my $updated_at = 	1693011480;
  my $task = $module->build_task('title', 'description', $created_at, $updated_at);
  $task->{id} = 1;
  my $actions = [];
  my $task_detail = $module->build_task_detail($task, $actions);
  is($task_detail, {
    id          => 1,
    title       => 'title',
    description => 'description',
    created_at  => $created_at,
    updated_at  => $updated_at,
    done        => 0,
    actions     => [],
  }, 'build task detail');
};

subtest_buffered build_task_detail_with_actions => sub {
  my $created_at = 	1693011473;
  my $updated_at = 	1693011480;
  my $task = $module->build_task('title', 'description', $created_at, $updated_at);
  $task->{id} = 1;
  my $actions = [
    {
      id          => 1,
      task_id     => 1,
      description => 'description',
      created_at  => 1693011473,
      updated_at  => 1693011480,
    },
  ];
  my $task_detail = $module->build_task_detail($task, $actions);
  is($task_detail, {
    id          => 1,
    title       => 'title',
    description => 'description',
    created_at  => $created_at,
    updated_at  => $updated_at,
    done        => 0,
    actions     => [
      {
        id          => 1,
        task_id     => 1,
        description => 'description',
        created_at  => 1693011473,
        updated_at  => 1693011480,
      },
    ],
  }, 'build task detail with actions');
};

subtest_buffered insert_query => sub {
  my $created_at = 	1693011473;
  my $updated_at = 	1693011480;
  my $task = $module->build_task('title', 'description', $created_at, $updated_at);
  my $query = [$module->insert_query($task)];
  is($query, ['insert', 'task', $task], 'insert query');
};

subtest_buffered get_by_id_query => sub {
  my $query = [$module->get_by_id_query(1)];
  is($query, ['single', 'task', {id => 1}], 'get by id query');
};

subtest_buffered select_all_query => sub {
  my $query = [$module->select_all_query()];
  is($query, ['select', 'task', {}]), 'select all query';
};

subtest_buffered update_query => sub {
  my $task = $module->build_task('title', 'description', 1, 2);
  my $query = [$module->update_query(1, $task)];
  is($query, ['update', 'task', $task, {id => 1}]), 'update query';
};

subtest_buffered as_done_query => sub {
  my $query = [$module->as_done_query(1, 2)];
  is($query, ['update', 'task', {done => 1, updated_at => 2}, {id => 1}], 'as done query');
};

subtest_buffered delete_query => sub {
  my $query = [$module->delete_query(1)];
  is($query, ['delete', 'task', {id => 1}], 'delete query');
};

done_testing;