from typing import Any

class KazooException(Exception): ...
class ZookeeperError(KazooException): ...
class CancelledError(KazooException): ...
class ConfigurationError(KazooException): ...
class ZookeeperStoppedError(KazooException): ...
class ConnectionDropped(KazooException): ...
class LockTimeout(KazooException): ...
class WriterNotClosedException(KazooException): ...

EXCEPTIONS = ...  # type: Any

class RolledBackError(ZookeeperError): ...
class SystemZookeeperError(ZookeeperError): ...
class RuntimeInconsistency(ZookeeperError): ...
class DataInconsistency(ZookeeperError): ...
class ConnectionLoss(ZookeeperError): ...
class MarshallingError(ZookeeperError): ...
class UnimplementedError(ZookeeperError): ...
class OperationTimeoutError(ZookeeperError): ...
class BadArgumentsError(ZookeeperError): ...
class NewConfigNoQuorumError(ZookeeperError): ...
class ReconfigInProcessError(ZookeeperError): ...
class APIError(ZookeeperError): ...
class NoNodeError(ZookeeperError): ...
class NoAuthError(ZookeeperError): ...
class BadVersionError(ZookeeperError): ...
class NoChildrenForEphemeralsError(ZookeeperError): ...
class NodeExistsError(ZookeeperError): ...
class NotEmptyError(ZookeeperError): ...
class SessionExpiredError(ZookeeperError): ...
class InvalidCallbackError(ZookeeperError): ...
class InvalidACLError(ZookeeperError): ...
class AuthFailedError(ZookeeperError): ...
class SessionMovedError(ZookeeperError): ...
class NotReadOnlyCallError(ZookeeperError): ...
class ConnectionClosedError(SessionExpiredError): ...

ConnectionLossException = ...  # type: Any
MarshallingErrorException = ...  # type: Any
SystemErrorException = ...  # type: Any
RuntimeInconsistencyException = ...  # type: Any
DataInconsistencyException = ...  # type: Any
UnimplementedException = ...  # type: Any
OperationTimeoutException = ...  # type: Any
BadArgumentsException = ...  # type: Any
ApiErrorException = ...  # type: Any
NoNodeException = ...  # type: Any
NoAuthException = ...  # type: Any
BadVersionException = ...  # type: Any
NoChildrenForEphemeralsException = ...  # type: Any
NodeExistsException = ...  # type: Any
InvalidACLException = ...  # type: Any
AuthFailedException = ...  # type: Any
NotEmptyException = ...  # type: Any
SessionExpiredException = ...  # type: Any
InvalidCallbackException = ...  # type: Any
