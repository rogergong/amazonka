{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies      #-}

-- Derived from AWS service descriptions, licensed under Apache 2.0.

-- |
-- Module      : Network.AWS.ECS.Types
-- Copyright   : (c) 2013-2015 Brendan Hay
-- License     : Mozilla Public License, v. 2.0.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--
module Network.AWS.ECS.Types
    (
    -- * Service
      ECS

    -- * Errors
    , _InvalidParameterException
    , _ServerException
    , _ClusterContainsServicesException
    , _ClusterContainsContainerInstancesException
    , _ServiceNotActiveException
    , _NoUpdateAvailableException
    , _ClusterNotFoundException
    , _ServiceNotFoundException
    , _MissingVersionException
    , _UpdateInProgressException
    , _ClientException

    -- * AgentUpdateStatus
    , AgentUpdateStatus (..)

    -- * DesiredStatus
    , DesiredStatus (..)

    -- * SortOrder
    , SortOrder (..)

    -- * TaskDefinitionStatus
    , TaskDefinitionStatus (..)

    -- * TransportProtocol
    , TransportProtocol (..)

    -- * Cluster
    , Cluster
    , cluster
    , cluStatus
    , cluClusterARN
    , cluRunningTasksCount
    , cluRegisteredContainerInstancesCount
    , cluPendingTasksCount
    , cluClusterName
    , cluActiveServicesCount

    -- * Container
    , Container
    , container
    , conNetworkBindings
    , conContainerARN
    , conTaskARN
    , conLastStatus
    , conReason
    , conName
    , conExitCode

    -- * ContainerDefinition
    , ContainerDefinition
    , containerDefinition
    , cdImage
    , cdCommand
    , cdVolumesFrom
    , cdEnvironment
    , cdEntryPoint
    , cdPortMappings
    , cdMemory
    , cdName
    , cdMountPoints
    , cdLinks
    , cdEssential
    , cdCpu

    -- * ContainerInstance
    , ContainerInstance
    , containerInstance
    , ciStatus
    , ciRunningTasksCount
    , ciRemainingResources
    , ciEc2InstanceId
    , ciContainerInstanceARN
    , ciAgentConnected
    , ciVersionInfo
    , ciAgentUpdateStatus
    , ciPendingTasksCount
    , ciRegisteredResources

    -- * ContainerOverride
    , ContainerOverride
    , containerOverride
    , coCommand
    , coEnvironment
    , coName

    -- * ContainerService
    , ContainerService
    , containerService
    , csStatus
    , csRunningCount
    , csClusterARN
    , csDesiredCount
    , csLoadBalancers
    , csPendingCount
    , csEvents
    , csServiceName
    , csDeployments
    , csTaskDefinition
    , csServiceARN
    , csRoleARN

    -- * Deployment
    , Deployment
    , deployment
    , depStatus
    , depRunningCount
    , depCreatedAt
    , depDesiredCount
    , depPendingCount
    , depId
    , depTaskDefinition
    , depUpdatedAt

    -- * Failure
    , Failure
    , failure
    , faiArn
    , faiReason

    -- * HostVolumeProperties
    , HostVolumeProperties
    , hostVolumeProperties
    , hvpSourcePath

    -- * KeyValuePair
    , KeyValuePair
    , keyValuePair
    , kvpValue
    , kvpName

    -- * LoadBalancer
    , LoadBalancer
    , loadBalancer
    , lbLoadBalancerName
    , lbContainerName
    , lbContainerPort

    -- * MountPoint
    , MountPoint
    , mountPoint
    , mpContainerPath
    , mpSourceVolume
    , mpReadOnly

    -- * NetworkBinding
    , NetworkBinding
    , networkBinding
    , nbBindIP
    , nbProtocol
    , nbHostPort
    , nbContainerPort

    -- * PortMapping
    , PortMapping
    , portMapping
    , pmProtocol
    , pmHostPort
    , pmContainerPort

    -- * Resource
    , Resource
    , resource
    , resStringSetValue
    , resIntegerValue
    , resDoubleValue
    , resLongValue
    , resName
    , resType

    -- * ServiceEvent
    , ServiceEvent
    , serviceEvent
    , seCreatedAt
    , seId
    , seMessage

    -- * Task
    , Task
    , task
    , tasDesiredStatus
    , tasClusterARN
    , tasOverrides
    , tasTaskARN
    , tasContainerInstanceARN
    , tasLastStatus
    , tasContainers
    , tasStartedBy
    , tasTaskDefinitionARN

    -- * TaskDefinition
    , TaskDefinition
    , taskDefinition
    , tdStatus
    , tdFamily
    , tdContainerDefinitions
    , tdTaskDefinitionARN
    , tdRevision
    , tdVolumes

    -- * TaskOverride
    , TaskOverride
    , taskOverride
    , toContainerOverrides

    -- * VersionInfo
    , VersionInfo
    , versionInfo
    , viAgentVersion
    , viAgentHash
    , viDockerVersion

    -- * Volume
    , Volume
    , volume
    , volName
    , volHost

    -- * VolumeFrom
    , VolumeFrom
    , volumeFrom
    , vfSourceContainer
    , vfReadOnly
    ) where

import           Network.AWS.ECS.Types.Product
import           Network.AWS.ECS.Types.Sum
import           Network.AWS.Prelude
import           Network.AWS.Sign.V4

-- | Version @2014-11-13@ of the Amazon EC2 Container Service SDK.
data ECS

instance AWSService ECS where
    type Sg ECS = V4
    service = const svc
      where
        svc =
            Service
            { _svcAbbrev = "ECS"
            , _svcPrefix = "ecs"
            , _svcVersion = "2014-11-13"
            , _svcEndpoint = defaultEndpoint svc
            , _svcTimeout = Just 70000000
            , _svcStatus = statusSuccess
            , _svcError = parseJSONError
            , _svcRetry = retry
            }
        retry =
            Exponential
            { _retryBase = 5.0e-2
            , _retryGrowth = 2
            , _retryAttempts = 5
            , _retryCheck = check
            }
        check e
          | has (hasCode "ThrottlingException" . hasStatus 400) e =
              Just "throttling_exception"
          | has (hasCode "Throttling" . hasStatus 400) e = Just "throttling"
          | has (hasStatus 503) e = Just "service_unavailable"
          | has (hasStatus 500) e = Just "general_server_error"
          | has (hasStatus 509) e = Just "limit_exceeded"
          | otherwise = Nothing

-- | The specified parameter is invalid. Review the available parameters for
-- the API request.
_InvalidParameterException :: AWSError a => Getting (First ServiceError) a ServiceError
_InvalidParameterException =
    _ServiceError . hasCode "InvalidParameterException"

-- | These errors are usually caused by a server-side issue.
_ServerException :: AWSError a => Getting (First ServiceError) a ServiceError
_ServerException = _ServiceError . hasCode "ServerException"

-- | You cannot delete a cluster that contains services. You must first
-- update the service to reduce its desired task count to 0 and then delete
-- the service. For more information, see UpdateService and DeleteService.
_ClusterContainsServicesException :: AWSError a => Getting (First ServiceError) a ServiceError
_ClusterContainsServicesException =
    _ServiceError . hasCode "ClusterContainsServicesException"

-- | You cannot delete a cluster that has registered container instances. You
-- must first deregister the container instances before you can delete the
-- cluster. For more information, see DeregisterContainerInstance.
_ClusterContainsContainerInstancesException :: AWSError a => Getting (First ServiceError) a ServiceError
_ClusterContainsContainerInstancesException =
    _ServiceError . hasCode "ClusterContainsContainerInstancesException"

-- | The specified service is not active. You cannot update a service that is
-- not active. If you have previously deleted a service, you can recreate
-- it with CreateService.
_ServiceNotActiveException :: AWSError a => Getting (First ServiceError) a ServiceError
_ServiceNotActiveException =
    _ServiceError . hasCode "ServiceNotActiveException"

-- | There is no update available for this Amazon ECS container agent. This
-- could be because the agent is already running the latest version, or it
-- is so old that there is no update path to the current version.
_NoUpdateAvailableException :: AWSError a => Getting (First ServiceError) a ServiceError
_NoUpdateAvailableException =
    _ServiceError . hasCode "NoUpdateAvailableException"

-- | The specified cluster could not be found. You can view your available
-- clusters with ListClusters. Amazon ECS clusters are region-specific.
_ClusterNotFoundException :: AWSError a => Getting (First ServiceError) a ServiceError
_ClusterNotFoundException = _ServiceError . hasCode "ClusterNotFoundException"

-- | The specified service could not be found. You can view your available
-- services with ListServices. Amazon ECS services are cluster-specific and
-- region-specific.
_ServiceNotFoundException :: AWSError a => Getting (First ServiceError) a ServiceError
_ServiceNotFoundException = _ServiceError . hasCode "ServiceNotFoundException"

-- | Amazon ECS is unable to determine the current version of the Amazon ECS
-- container agent on the container instance and does not have enough
-- information to proceed with an update. This could be because the agent
-- running on the container instance is an older or custom version that
-- does not use our version information.
_MissingVersionException :: AWSError a => Getting (First ServiceError) a ServiceError
_MissingVersionException = _ServiceError . hasCode "MissingVersionException"

-- | There is already a current Amazon ECS container agent update in progress
-- on the specified container instance. If the container agent becomes
-- disconnected while it is in a transitional stage, such as @PENDING@ or
-- @STAGING@, the update process can get stuck in that state. However, when
-- the agent reconnects, it will resume where it stopped previously.
_UpdateInProgressException :: AWSError a => Getting (First ServiceError) a ServiceError
_UpdateInProgressException =
    _ServiceError . hasCode "UpdateInProgressException"

-- | These errors are usually caused by something the client did, such as use
-- an action or resource on behalf of a user that doesn\'t have permission
-- to use the action or resource, or specify an identifier that is not
-- valid.
_ClientException :: AWSError a => Getting (First ServiceError) a ServiceError
_ClientException = _ServiceError . hasCode "ClientException"
