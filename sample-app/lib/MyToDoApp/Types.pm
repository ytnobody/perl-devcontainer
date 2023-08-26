package MyToDoApp::Types;
use v5.36;
use Types::Standard -types;
use Type::Alias
  -alias => [qw[ 
    Action 
    Task 
    CreateActionParams
    CreateTaskParams
    UpdateActionParams
    UpdateTaskParams
    CreateTaskRequestBody 
    UpdateTaskRequestBody 
    CreateActionRequestBody
    TaskDetailResponse
  ]];
use Exporter 'import';
our @EXPORT = qw(
  Action 
  Task
  CreateActionParams
  CreateTaskParams
  UpdateActionParams
  UpdateTaskParams
  CreateTaskRequestBody
  UpdateTaskRequestBody
  CreateActionRequestBody
  TaskDetailResponse
);

type Action => {
  id          => Int,
  task_id     => Int,
  description => Str,
  created_at  => Int,
  updated_at  => Int,
};

type Task => {
  id          => Int,
  title       => Str,
  description => Str,
  created_at  => Int,
  updated_at  => Int,
  done        => Int,
};

type CreateActionParams => {
  task_id     => Int,
  description => Str,
  created_at  => Int,
  updated_at  => Int,
};

type CreateTaskParams => {
  title       => Str,
  description => Str,
  created_at  => Int,
  updated_at  => Int,
  done        => Int,
};

type CreateActionParams => CreateActionParams;

type UpdateTaskParams => CreateTaskParams;

type CreateTaskRequestBody => {
  title       => Str,
  description => Str,
};

type UpdateTaskRequestBody => {
  title       => Str,
  description => Str,
};

type CreateActionRequestBody => {
  description => Str,
};

type TaskDetailResponse => {
  id          => Int,
  title       => Str,
  description => Str,
  created_at  => Int,
  updated_at  => Int,
  done        => Int,
  actions     => ArrayRef[Action],
};

1;