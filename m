Return-Path: <SRS0=tuHM=5E=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0626C4332D
	for <linux-integrity@archiver.kernel.org>; Thu, 19 Mar 2020 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12222072C
	for <linux-integrity@archiver.kernel.org>; Thu, 19 Mar 2020 16:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NzrR39pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgCSQgs (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:36:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCSQgs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 12:36:48 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 77B1420110DE;
        Thu, 19 Mar 2020 09:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77B1420110DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584635807;
        bh=yd9d5arS28Y0MpXzfyytl10uscUOaQkwlZq8s74jEA4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NzrR39pWMRN/5Rrt7s+my6cdXvTRSQNOxDrucJFta8Lj0EAJyxJV53rjJJIeSlkMR
         5v8Po3qQ0VzZrDtkeJrL78rEfeoXFv6VG+bltZycoY6bSpfUc49Ixa2PiNOklPXXSJ
         qjsAE4U+TnpKCMqMXTQvACWSPYMwoSCORCBuiOWY=
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190817233348.22349-1-vt@altlinux.org>
 <392fed51-095d-2a6f-5eda-317e3bbc8707@linux.microsoft.com>
 <20200319154957.ijh7tbfp4d7iwcef@altlinux.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a8b77ade-58bf-88ac-542b-b8fbdd651db4@linux.microsoft.com>
Date:   Thu, 19 Mar 2020 09:36:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319154957.ijh7tbfp4d7iwcef@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/19/20 8:49 AM, Vitaly Chikunov wrote:

> 
> Please run autogen.sh twice before running configure.
> 

That fixed the problem. Thanks Vitaly.

  -lakshmi
