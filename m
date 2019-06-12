Return-Path: <SRS0=7aJQ=UL=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668FC31E46
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Jun 2019 14:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C756A20B1F
	for <linux-integrity@archiver.kernel.org>; Wed, 12 Jun 2019 14:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfFLOqi (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:46:38 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42902 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfFLOqi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 10:46:38 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0BC0572CCAE;
        Wed, 12 Jun 2019 17:46:36 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E1B184A4AE7;
        Wed, 12 Jun 2019 17:46:35 +0300 (MSK)
Date:   Wed, 12 Jun 2019 17:46:35 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY
 API
Message-ID: <20190612144635.ouwifooi5bqq73ga@altlinux.org>
References: <20190323025633.26541-1-vt@altlinux.org>
 <1559069833.4139.25.camel@linux.ibm.com>
 <20190528224657.r6muelxxhjdgcyji@altlinux.org>
 <1559086262.4139.75.camel@linux.ibm.com>
 <1560349833.4578.25.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560349833.4578.25.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jun 12, 2019 at 10:30:33AM -0400, Mimi Zohar wrote:
> On Tue, 2019-05-28 at 19:31 -0400, Mimi Zohar wrote:
> > On Wed, 2019-05-29 at 01:46 +0300, Vitaly Chikunov wrote:
> 
> 
> > > I already tried to leave RSA handling as is for v1 signatures, because
> > > they are RSA specific anyway.
> > > 
> > > Also, I tried to leave most (external) API the same, except
> > > calc_keyid_v2 which now gets EVP_PKEY instead of RSA. Internally,
> > > find_keyid now returns EVP_PKEY too.
> > > 
> > > read_pub_key now extracts RSA from EVP_PKEY from read_pub_pkey.
> > 
> > Right. šSo why couldn't the first patch define read_pub_pkey(), but
> > only call it from read_pub_key(). šThen subsequent patches could call
> > read_pub_pkey() directly.
> > 
> > > 
> > > And calc_keyid_v2 now works internally slightly differently (and
> > > generally) to handle all possible key types.
> > > 
> > > Also, I run some tests with ASan.
> 
> Releasing a new version of ima-evm-utils is way over due. šI'd really
> like to release a new version of ima-evm-utils soon. šAre you planning
> on breaking this patch up?

Yes. Sorry for a delay. I will sent it soon.

Thanks,

