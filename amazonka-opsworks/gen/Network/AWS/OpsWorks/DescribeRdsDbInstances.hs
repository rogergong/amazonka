{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE NoImplicitPrelude          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}

-- {-# OPTIONS_GHC -fno-warn-unused-imports #-}
-- {-# OPTIONS_GHC -fno-warn-unused-binds  #-} doesnt work if wall is used
{-# OPTIONS_GHC -w #-}

-- Module      : Network.AWS.OpsWorks.DescribeRdsDbInstances
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Describes Amazon RDS instances.
module Network.AWS.OpsWorks.DescribeRdsDbInstances
    (
    -- * Request
      DescribeRdsDbInstances
    -- ** Request constructor
    , describeRdsDbInstances
    -- ** Request lenses
    , drdiRdsDbInstanceArns
    , drdiStackId

    -- * Response
    , DescribeRdsDbInstancesResponse
    -- ** Response constructor
    , describeRdsDbInstancesResponse
    -- ** Response lenses
    , drdirRdsDbInstances
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.OpsWorks.Types

data DescribeRdsDbInstances = DescribeRdsDbInstances
    { _drdiRdsDbInstanceArns :: [Text]
    , _drdiStackId           :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'DescribeRdsDbInstances' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'drdiRdsDbInstanceArns' @::@ ['Text']
--
-- * 'drdiStackId' @::@ 'Text'
--
describeRdsDbInstances :: Text -- ^ 'drdiStackId'
                       -> DescribeRdsDbInstances
describeRdsDbInstances p1 = DescribeRdsDbInstances
    { _drdiStackId           = p1
    , _drdiRdsDbInstanceArns = mempty
    }

-- | An array containing the ARNs of the instances to be described.
drdiRdsDbInstanceArns :: Lens' DescribeRdsDbInstances [Text]
drdiRdsDbInstanceArns =
    lens _drdiRdsDbInstanceArns (\s a -> s { _drdiRdsDbInstanceArns = a })

-- | The stack ID that the instances are registered with. The operation
-- returns descriptions of all registered Amazon RDS instances.
drdiStackId :: Lens' DescribeRdsDbInstances Text
drdiStackId = lens _drdiStackId (\s a -> s { _drdiStackId = a })

instance ToPath DescribeRdsDbInstances where
    toPath = const "/"

instance ToQuery DescribeRdsDbInstances where
    toQuery = const mempty

instance ToHeaders DescribeRdsDbInstances

instance ToBody DescribeRdsDbInstances where
    toBody = toBody . encode . _drdiStackId

newtype DescribeRdsDbInstancesResponse = DescribeRdsDbInstancesResponse
    { _drdirRdsDbInstances :: [RdsDbInstance]
    } deriving (Eq, Show, Generic, Monoid, Semigroup)

instance GHC.Exts.IsList DescribeRdsDbInstancesResponse where
    type Item DescribeRdsDbInstancesResponse = RdsDbInstance

    fromList = DescribeRdsDbInstancesResponse . GHC.Exts.fromList
    toList   = GHC.Exts.toList . _drdirRdsDbInstances

-- | 'DescribeRdsDbInstancesResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'drdirRdsDbInstances' @::@ ['RdsDbInstance']
--
describeRdsDbInstancesResponse :: DescribeRdsDbInstancesResponse
describeRdsDbInstancesResponse = DescribeRdsDbInstancesResponse
    { _drdirRdsDbInstances = mempty
    }

-- | An a array of RdsDbInstance objects that describe the instances.
drdirRdsDbInstances :: Lens' DescribeRdsDbInstancesResponse [RdsDbInstance]
drdirRdsDbInstances =
    lens _drdirRdsDbInstances (\s a -> s { _drdirRdsDbInstances = a })

instance AWSRequest DescribeRdsDbInstances where
    type Sv DescribeRdsDbInstances = OpsWorks
    type Rs DescribeRdsDbInstances = DescribeRdsDbInstancesResponse

    request  = post
    response = jsonResponse $ \h o -> DescribeRdsDbInstancesResponse
        <$> o .: "RdsDbInstances"
