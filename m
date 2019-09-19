Return-Path: <SRS0=qYdH=XO=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008BC3A5A6
	for <linux-integrity@archiver.kernel.org>; Thu, 19 Sep 2019 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4471621924
	for <linux-integrity@archiver.kernel.org>; Thu, 19 Sep 2019 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568899134;
	bh=RmRuvQY7wc8I3ZPaxJrwB6W3ylu7KqompsI3b24MR/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ovPWkfgJzFnGo0dAqJBoMJtpaARD+W3Qw/cYSHdZNGVMHLyDzRtWnyyGN9njFdjVm
	 Vn51AE83x9KmiX0N4YB4jjZV0+/2Y74upqEgjklIaAojp5CO/agSfALqRkpdUqA4/C
	 qXmBbrxCb7QxQLqtoFtyGMkVAHCCPhrtJI3lItkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbfISNSx (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:18:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbfISNSx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Sep 2019 09:18:53 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199A5217D6;
        Thu, 19 Sep 2019 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568899132;
        bh=RmRuvQY7wc8I3ZPaxJrwB6W3ylu7KqompsI3b24MR/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LbVc534Y9Yu7BRVE8RW7uub8HKU7QvfVIWN4EdtsAGAkzcHpr8+iHstqnnA0Vbl20
         GT37ZrvBmtT2cEfSl8ibF5dni8/QsJO2Y0SwTA80wMcHaxe1qVPqOxUdY4Xw1Qikfu
         EJzvwOZ/+6tK64MOlACS2Pji+XvWmcC7QLtyf5NA=
Date:   Thu, 19 Sep 2019 09:18:51 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
Message-ID: <20190919131851.GA8171@sasha-vm>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
 <1567041083.6115.133.camel@linux.ibm.com>
 <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
 <1567190507.10024.134.camel@linux.ibm.com>
 <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
 <1568035881.4614.347.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1568035881.4614.347.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 09, 2019 at 09:31:21AM -0400, Mimi Zohar wrote:
>On Tue, 2019-09-03 at 08:54 -0700, Lakshmi Ramasubramanian wrote:
>> On 8/30/19 11:41 AM, Mimi Zohar wrote:
>>
>> > No, the measurement list ima-sig template record contains both the
>> > file hash and signature.  There's no need to maintain a white list of
>> > either the file hashes or signed hashes.  All that is needed is the
>> > set of permitted public keys (eg. keys on the trusted IMA keyring).
>>
>> You are right - Thanks for the info.
>>
>> > Even though on the local system, files signed by the system owner
>> > would be permitted, the attestation server would be able to control
>> > access to whatever service.  For example, Trusted Network Connect
>> > (TNC) could control network access.  By measuring the keys on the
>> > builtin/secondary keyrings, that control is not based on who signed
>> > the software package, but based on who signed the certificate of the
>> > key that signed the software package.  My concern is how this level of
>> > indirection could be abused.
>> Since the signer of certificate of the key that signed the software
>> package changes much less frequently compared to the certificate of the
>> key used to sign the software package, the operational overhead on the
>> server side is significantly reduced.
>>
>> I understand there is another level of indirection here. But I am also
>> not clear how this can be abused.
>
>The remote attestation server could gate any service based on the
>certificate signer.  The first gated service, based on this feature,
>will probably be network access (eg. TNC).  If/when this feature is
>upstreamed, every company, including financial institutes,

I'm not sure why upstreaming this code will matter for those entities
you're concerned about. Any entity that provides a signed kernel image
is very well capable of including out of tree patches in that image.

>organizations, and governments will become THE certificate signer for
>their organization, in order to limit access to their network and
>systems.  Once that happens, how long will it be until the same
>feature will be abused and used to limit the individual's ability to
>pick and choose which applications may run on their systems.[1]

We do not restrict end use of the kernel; this is one of the main
reasons that the kernel is licensed under GPLv2 rather than GPLv3.
Please see https://lwn.net/Articles/200422/ .

We'd love to work with you on the technical aspects of this code to make
it acceptable to the IMA maintainers, but this work can't just be NACKed
based on a perceived end use of it.

--
Thanks,
Sasha
