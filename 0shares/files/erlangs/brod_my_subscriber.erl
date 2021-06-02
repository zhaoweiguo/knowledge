-module(my_subscriber).
-include_lib("brod/include/brod.hrl"). %% needed for the #kafka_message record definition

-export([start/1]).
-export([init/2, handle_message/4]). %% callback api

%% brod_group_subscriber behaviour callback
init(_GroupId, _Arg) -> {ok, []}.

%% brod_group_subscriber behaviour callback
handle_message(_Topic, Partition, Message, State) ->
  #kafka_message{ offset = Offset
                , key   = Key
                , value = Value
                } = Message,
  error_logger:info_msg("~p ~p: offset:~w key:~s value:~s\n",
                        [self(), Partition, Offset, Key, Value]),
  {ok, ack, State}.

%% @doc The brod client identified ClientId should have been started
%% either by configured in sys.config and started as a part of brod application
%% or started by brod:start_client/3
%% @end
-spec start(brod:client_id()) -> {ok, pid()}.
start(ClientId) ->
  Topic  = <<"brod-test-topic-1">>,
  %% commit offsets to kafka every 5 seconds
  GroupConfig = [{offset_commit_policy, commit_to_kafka_v2},
                 {offset_commit_interval_seconds, 5}
                ],
  GroupId = <<"my-unique-group-id-shared-by-all-members">>,
  ConsumerConfig = [{begin_offset, earliest}],
  brod:start_link_group_subscriber(ClientId, GroupId, [Topic],
                                   GroupConfig, ConsumerConfig,
                                   _CallbackModule  = ?MODULE,
                                   _CallbackInitArg = []).