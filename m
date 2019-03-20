Return-Path: <SRS0=28DF=RX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D44C43381
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8842146E
	for <linux-integrity@archiver.kernel.org>; Wed, 20 Mar 2019 08:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="JDUjKMuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfCTILy (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:11:54 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:46422 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfCTILy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Mar 2019 04:11:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 1AD82B63B5E;
        Wed, 20 Mar 2019 11:11:51 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id j6q4VKNRwDjV; Wed, 20 Mar 2019 11:11:50 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id B781DB63BDA;
        Wed, 20 Mar 2019 11:11:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru B781DB63BDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1553069510;
        bh=oXpelYSraZZX7/YmaDmAQEtRDfl7PGrPaKCXInUp660=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=JDUjKMuJcl2r4E7OaKB56UvXPdVQAAHqLH72HP5cOOOx0mvWN8FFrINntLmytSbHZ
         ktx3uNPsqGcReTdTrumyRXo+Hxjm6ICh0eCoOMXxcwqzvknG0fqLA3TncM19XPq2yj
         nDFmV6yTrgLUBqLxBDI0lYpXaHvpRGERQ2sUOmIg64IB3rYF7xFcDYzcEAt1t7vt4+
         qYsRmnLlVm3w1YtdQ34EH2w/5ph0OJv1xvS2unozYFr04RaFTyoAbbnCCdYwf1rmP5
         60gtYey8azfnFbZ7TopsYM79SK65MaN3+RuO4+oWH0dtmB4KWAeWGRtc2/B7Xd/wb9
         uHIHqKf17HcWA==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dac0Ius_oyde; Wed, 20 Mar 2019 11:11:50 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 9FD05B63B5E;
        Wed, 20 Mar 2019 11:11:50 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
 <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
 <1553015134.4899.82.camel@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <a9830bde-8157-6078-b544-fcffb20d2501@omprussia.ru>
Date:   Wed, 20 Mar 2019 11:11:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1553015134.4899.82.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 19.03.2019 20:05, Mimi Zohar wrote:
> Ok, so we can start there and modify the existing ima_file_mmap() to
> verify file signatures that are being mmap'ed read.=C2=A0=C2=A0The ques=
tion will
> then become what to do with mprotect write and execute.
>=20
> And what would you do with the mprotect without a file descriptor?
>=20
> The mmap signature verification status is cached in the iint, based on
> the inode. =C2=A0I think whatever solution will need to be able to acce=
ss
> this cached information.

Well, I think that IMA should check every executable page having a backin=
g
storage, i.e. when a page is mmapped from a file. So it will not be possi=
ble
to store any new untrusted code on the disk.

(Except of reading it into read-only page, then creating anonymous execut=
able
page and copying it there.)

As for creating anonymous executable pages, yes, there is nothing to chec=
k.
May be there should be some another LSM or prctl for that: whether some
process should have anonymous executable pages at all. I think that since
stack and data should be non-executable, normal apps should not have any
anonymous executable pages at all.

On 19.03.2019 20:07, Matthew Garrett wrote:
> Remember that an application can also open a file read-only and then
> execute the code under an interpreter. If you have code that's
> deliberately trying to undermine IMA then it can do so - the goal is
> to use IMA to ensure that you have appropriate measurement or
> appraisal in order to avoid that in the first place.

As for scripts interpreters like bash, yes, it will not protect against i=
t.
But IMA can check e.g. all files read by root including non-executable on=
es.

My point was about better protecting of shared libraries making life hard=
er
for exploits that are downloading extra code from external servers.
