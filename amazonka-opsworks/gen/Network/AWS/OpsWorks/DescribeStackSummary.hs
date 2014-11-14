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

-- Module      : Network.AWS.OpsWorks.DescribeStackSummary
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Describes the number of layers and apps in a specified stack, and the
-- number of instances in each state, such as running_setup or online.
-- Required Permissions: To use this action, an IAM user must have a Show,
-- Deploy, or Manage permissions level for the stack, or an attached policy
-- that explicitly grants permissions. For more information on user
-- permissions, see Managing User Permissions.
module Network.AWS.OpsWorks.DescribeStackSummary
    (
    -- * Request
      DescribeStackSummary
    -- ** Request constructor
    , describeStackSummary
    -- ** Request lenses
    , dssStackId

    -- * Response
    , DescribeStackSummaryResponse
    -- ** Response constructor
    , describeStackSummaryResponse
    -- ** Response lenses
    , dssrStackSummary
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.OpsWorks.Types

newtype DescribeStackSummary = DescribeStackSummary
    { _dssStackId :: Text
    } deriving (Eq, Ord, Show, Generic, Monoid, IsString)

-- | 'DescribeStackSummary' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dssStackId' @::@ 'Text'
--
describeStackSummary :: Text -- ^ 'dssStackId'
                     -> DescribeStackSummary
describeStackSummary p1 = DescribeStackSummary
    { _dssStackId = p1
    }

-- | The stack ID.
dssStackId :: Lens' DescribeStackSummary Text
dssStackId = lens _dssStackId (\s a -> s { _dssStackId = a })

instance ToPath DescribeStackSummary where
    toPath = const "/"

instance ToQuery DescribeStackSummary where
    toQuery = const mempty

instance ToHeaders DescribeStackSummary

instance ToBody DescribeStackSummary where
    toBody = toBody . encode . _dssStackId

newtype DescribeStackSummaryResponse = DescribeStackSummaryResponse
    { _dssrStackSummary :: Maybe StackSummary
    } deriving (Eq, Show, Generic)

-- | 'DescribeStackSummaryResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'dssrStackSummary' @::@ 'Maybe' 'StackSummary'
--
describeStackSummaryResponse :: DescribeStackSummaryResponse
describeStackSummaryResponse = DescribeStackSummaryResponse
    { _dssrStackSummary = Nothing
    }

-- | A StackSummary object that contains the results.
dssrStackSummary :: Lens' DescribeStackSummaryResponse (Maybe StackSummary)
dssrStackSummary = lens _dssrStackSummary (\s a -> s { _dssrStackSummary = a })

instance AWSRequest DescribeStackSummary where
    type Sv DescribeStackSummary = OpsWorks
    type Rs DescribeStackSummary = DescribeStackSummaryResponse

    request  = post
    response = jsonResponse $ \h o -> DescribeStackSummaryResponse
        <$> o .: "StackSummary"
