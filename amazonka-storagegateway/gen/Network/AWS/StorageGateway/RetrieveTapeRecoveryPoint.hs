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

-- Module      : Network.AWS.StorageGateway.RetrieveTapeRecoveryPoint
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | Retrieves the recovery point for the specified virtual tape. A recovery
-- point is a point in time view of a virtual tape at which all the data on
-- the tape is consistent. If your gateway crashes, virtual tapes that have
-- recovery points can be recovered to a new gateway.
module Network.AWS.StorageGateway.RetrieveTapeRecoveryPoint
    (
    -- * Request
      RetrieveTapeRecoveryPoint
    -- ** Request constructor
    , retrieveTapeRecoveryPoint
    -- ** Request lenses
    , rtrpGatewayARN
    , rtrpTapeARN

    -- * Response
    , RetrieveTapeRecoveryPointResponse
    -- ** Response constructor
    , retrieveTapeRecoveryPointResponse
    -- ** Response lenses
    , rtrprTapeARN
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.StorageGateway.Types

data RetrieveTapeRecoveryPoint = RetrieveTapeRecoveryPoint
    { _rtrpGatewayARN :: Text
    , _rtrpTapeARN    :: Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'RetrieveTapeRecoveryPoint' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rtrpGatewayARN' @::@ 'Text'
--
-- * 'rtrpTapeARN' @::@ 'Text'
--
retrieveTapeRecoveryPoint :: Text -- ^ 'rtrpTapeARN'
                          -> Text -- ^ 'rtrpGatewayARN'
                          -> RetrieveTapeRecoveryPoint
retrieveTapeRecoveryPoint p1 p2 = RetrieveTapeRecoveryPoint
    { _rtrpTapeARN    = p1
    , _rtrpGatewayARN = p2
    }

rtrpGatewayARN :: Lens' RetrieveTapeRecoveryPoint Text
rtrpGatewayARN = lens _rtrpGatewayARN (\s a -> s { _rtrpGatewayARN = a })

-- | The Amazon Resource Name (ARN) of the virtual tape for which you want to
-- retrieve the recovery point.
rtrpTapeARN :: Lens' RetrieveTapeRecoveryPoint Text
rtrpTapeARN = lens _rtrpTapeARN (\s a -> s { _rtrpTapeARN = a })

instance ToPath RetrieveTapeRecoveryPoint where
    toPath = const "/"

instance ToQuery RetrieveTapeRecoveryPoint where
    toQuery = const mempty

instance ToHeaders RetrieveTapeRecoveryPoint

instance ToBody RetrieveTapeRecoveryPoint where
    toBody = toBody . encode . _rtrpTapeARN

newtype RetrieveTapeRecoveryPointResponse = RetrieveTapeRecoveryPointResponse
    { _rtrprTapeARN :: Maybe Text
    } deriving (Eq, Ord, Show, Generic, Monoid)

-- | 'RetrieveTapeRecoveryPointResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'rtrprTapeARN' @::@ 'Maybe' 'Text'
--
retrieveTapeRecoveryPointResponse :: RetrieveTapeRecoveryPointResponse
retrieveTapeRecoveryPointResponse = RetrieveTapeRecoveryPointResponse
    { _rtrprTapeARN = Nothing
    }

-- | The Amazon Resource Name (ARN) of the virtual tape for which the recovery
-- point was retrieved.
rtrprTapeARN :: Lens' RetrieveTapeRecoveryPointResponse (Maybe Text)
rtrprTapeARN = lens _rtrprTapeARN (\s a -> s { _rtrprTapeARN = a })

instance AWSRequest RetrieveTapeRecoveryPoint where
    type Sv RetrieveTapeRecoveryPoint = StorageGateway
    type Rs RetrieveTapeRecoveryPoint = RetrieveTapeRecoveryPointResponse

    request  = post
    response = jsonResponse $ \h o -> RetrieveTapeRecoveryPointResponse
        <$> o .: "TapeARN"
