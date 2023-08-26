package MyToDoApp::Infra::Database;

use v5.36;
use Otogiri;

our $connection = Otogiri->new(
  connect_info => [
    $ENV{MYTODOAPP_DSN} // 'dbi:SQLite:dbname=db/data/development.sqlite3',
    $ENV{MYTODOAPP_USER} // '',
    $ENV{MYTODOAPP_PASSWORD} // '',
    {RaiseError => 1},
  ],
  strict => 0,
);

sub connection { $connection }

sub execute {
  my ($class, $command, $table, @params) = @_;
  return $connection->$command($table, @params);
}

sub last_insert_id {
  my ($class) = @_;
  return $class->execute('last_insert_id');
}

1;