Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AEAC433B4
	for <linux-integrity@archiver.kernel.org>; Tue,  4 May 2021 23:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84577613C4
	for <linux-integrity@archiver.kernel.org>; Tue,  4 May 2021 23:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhEDXoR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 4 May 2021 19:44:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52214 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhEDXoP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 19:44:15 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4129872C8B5;
        Wed,  5 May 2021 02:43:18 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 2F7BE7CC8AF; Wed,  5 May 2021 02:43:18 +0300 (MSK)
Date:   Wed, 5 May 2021 02:43:18 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
Message-ID: <20210504234318.GC10037@altlinux.org>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-2-vt@altlinux.org>
 <3caf1395-78ef-936f-4c8a-dbd56d0b6fea@linux.ibm.com>
 <20210504231804.wxewx6wvc5rezxm7@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504231804.wxewx6wvc5rezxm7@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 05, 2021 at 02:18:04AM +0300, Vitaly Chikunov wrote:
> Stefan,
> 
> On Tue, May 04, 2021 at 08:51:03AM -0400, Stefan Berger wrote:
> > > @@ -932,8 +932,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> > >   		return -1;
> > >   	}
> > > -	calc_keyid_v2(&keyid, name, pkey);
> > > -	hdr->keyid = keyid;
> > > +	if (imaevm_params.keyid)
> > > +		hdr->keyid = htonl(imaevm_params.keyid);
> > 
> > 
> > Nit: Since existing code uses __be32_to_cpup I would use __cpu_to_be32 here.
> 
> That __be32_to_cpup usage is highly dubious. Perhaps, it should be
> converted to some user-space and standard functions like be32toh(3).

By the way, be32toh() is identical to ntohl().

I wonder what was the reason for the existing code to use these obscure
linux-specific functions instead of posix interface described in
byteorder(3)?


-- 
ldv
