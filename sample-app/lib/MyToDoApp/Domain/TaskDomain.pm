package MyToDoApp::Domain::TaskDomain;

use v5.36;
use Types::Standard -types;
use Function::Parameters;

use MyToDoApp::Types qw(CreateTaskParams UpdateTaskParams Action Task);

our $table = 'task';

fun build_task ($class, Str $title, Str $description, Int $created_at, Int $updated_at) {
  my $task = {
    title       => $title,
    description => $description,
    created_at  => $created_at,
    updated_at  => $updated_at,
    done        => 0,
  };
  return $task;
}

fun build_task_detail ($class, Task $task, ArrayRef[Action] $actions) {
  my $res = {
    id          => $task->{id},
    title       => $task->{title},
    description => $task->{description},
    created_at  => $task->{created_at},
    updated_at  => $task->{updated_at},
    done        => $task->{done},
    actions     => $actions,
  };
  return $res;
}

fun insert_query ($class, CreateTaskParams $task) {
  return ('insert', $table, $task);
}

fun get_by_id_query ($class, Int $id) {
  return ('single', $table, {id => $id});
}

fun select_all_query ($class) {
  return ('select', $table, {});
}

fun update_query ($class, Int $id, UpdateTaskParams $task) {
  return ('update', $table, $task, {id => $id});
}

fun as_done_query ($class, Int $id, Int $updated_at) {
  return ('update', $table, {done => 1, updated_at => $updated_at}, {id => $id});
}

fun delete_query ($class, Int $id) {
  return ('delete', $table, {id => $id});
}

1;