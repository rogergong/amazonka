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

-- Module      : Network.AWS.Route53Domains.CheckDomainAvailability
-- Copyright   : (c) 2013-2014 Brendan Hay <brendan.g.hay@gmail.com>
-- License     : This Source Code Form is subject to the terms of
--               the Mozilla Public License, v. 2.0.
--               A copy of the MPL can be found in the LICENSE file or
--               you can obtain it at http://mozilla.org/MPL/2.0/.
-- Maintainer  : Brendan Hay <brendan.g.hay@gmail.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)

-- | This operation checks the availability of one domain name. You can access
-- this API without authenticating. Note that if the availability status of a
-- domain is pending, you must submit another request to determine the
-- availability of the domain name.
module Network.AWS.Route53Domains.CheckDomainAvailability
    (
    -- * Request
      CheckDomainAvailability
    -- ** Request constructor
    , checkDomainAvailability
    -- ** Request lenses
    , cdaDomainName
    , cdaIdnLangCode

    -- * Response
    , CheckDomainAvailabilityResponse
    -- ** Response constructor
    , checkDomainAvailabilityResponse
    -- ** Response lenses
    , cdarAvailability
    ) where

import Network.AWS.Prelude
import Network.AWS.Request
import Network.AWS.Route53Domains.Types

data CheckDomainAvailability = CheckDomainAvailability
    { _cdaDomainName  :: Text
    , _cdaIdnLangCode :: Maybe Text
    } deriving (Eq, Ord, Show, Generic)

-- | 'CheckDomainAvailability' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdaDomainName' @::@ 'Text'
--
-- * 'cdaIdnLangCode' @::@ 'Maybe' 'Text'
--
checkDomainAvailability :: Text -- ^ 'cdaDomainName'
                        -> CheckDomainAvailability
checkDomainAvailability p1 = CheckDomainAvailability
    { _cdaDomainName  = p1
    , _cdaIdnLangCode = Nothing
    }

-- | The name of a domain. Type: String Default: None Constraints: The domain
-- name can contain only the letters a through z, the numbers 0 through 9,
-- and hyphen (-). Internationalized Domain Names are not supported.
-- Required: Yes.
cdaDomainName :: Lens' CheckDomainAvailability Text
cdaDomainName = lens _cdaDomainName (\s a -> s { _cdaDomainName = a })

-- | Reserved for future use.
cdaIdnLangCode :: Lens' CheckDomainAvailability (Maybe Text)
cdaIdnLangCode = lens _cdaIdnLangCode (\s a -> s { _cdaIdnLangCode = a })

instance ToPath CheckDomainAvailability where
    toPath = const "/"

instance ToQuery CheckDomainAvailability where
    toQuery = const mempty

instance ToHeaders CheckDomainAvailability

instance ToBody CheckDomainAvailability where
    toBody = toBody . encode . _cdaDomainName

newtype CheckDomainAvailabilityResponse = CheckDomainAvailabilityResponse
    { _cdarAvailability :: Text
    } deriving (Eq, Ord, Show, Generic, Monoid, IsString)

-- | 'CheckDomainAvailabilityResponse' constructor.
--
-- The fields accessible through corresponding lenses are:
--
-- * 'cdarAvailability' @::@ 'Text'
--
checkDomainAvailabilityResponse :: Text -- ^ 'cdarAvailability'
                                -> CheckDomainAvailabilityResponse
checkDomainAvailabilityResponse p1 = CheckDomainAvailabilityResponse
    { _cdarAvailability = p1
    }

-- | Whether the domain name is available for registering. Type: String Valid
-- values: AVAILABLE – The domain name is available. AVAILABLE_RESERVED –
-- The domain name is reserved under specific conditions. AVAILABLE_PREORDER
-- – The domain name is available and can be preordered. UNAVAILABLE – The
-- domain name is not available. UNAVAILABLE_PREMIUM – The domain name is
-- not available. UNAVAILABLE_RESTRICTED – The domain name is forbidden.
-- RESERVED – The domain name has been reserved for another person or
-- organization.
cdarAvailability :: Lens' CheckDomainAvailabilityResponse Text
cdarAvailability = lens _cdarAvailability (\s a -> s { _cdarAvailability = a })

instance AWSRequest CheckDomainAvailability where
    type Sv CheckDomainAvailability = Route53Domains
    type Rs CheckDomainAvailability = CheckDomainAvailabilityResponse

    request  = post
    response = jsonResponse $ \h o -> CheckDomainAvailabilityResponse
        <$> o .: "Availability"
