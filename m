Return-Path: <SRS0=sVEj=RW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB226C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 12:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A602133D
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 12:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="fPwKU57S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCSMTj (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:19:39 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:55904 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfCSMTj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Mar 2019 08:19:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 10B56B54CAC;
        Tue, 19 Mar 2019 15:19:38 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VDAfCREokHIy; Tue, 19 Mar 2019 15:19:37 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id BCC0BB54CAB;
        Tue, 19 Mar 2019 15:19:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru BCC0BB54CAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1552997977;
        bh=FrMNj/F8uIA6Jj6PyGP+JyewVZpfZvGRDH9ECYUvHWE=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=fPwKU57SRyhwDOozgTjcMwFsohBH6+85u4Kzrs0K/G0EmSAnHI6UAC2OYreyfTPGA
         u2X2fD+IxtS8xXYbkorXfTm7M9jg9rqMlXKaCoFxkIVHTZMIZkjd7RtPePN8G2Y8Qd
         Es4QmnFJQet+4Bg1s41w3iK3Wh1bU/PzivyxFVwUQoMOvwRxkSyRox6eyphna09sp3
         ZrtqaSRZxy/60qz30oA0pnFpqbLnY1imGbyQMCrb1NSW3kfytvDWTFyquBy0HoCe1O
         VQASmQdDFRcBTAPXiCGSNfJSz5yuNRcNzyvtZ9VaBnZ1EyEyY4Wwgp7hHzTri4vTLX
         H01pfCbdxo+hg==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9A2qfDhALkef; Tue, 19 Mar 2019 15:19:37 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 92B40B54CAA;
        Tue, 19 Mar 2019 15:19:37 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
 <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
 <1552994559.4899.26.camel@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <84145490-6f70-214f-8241-42d556590240@omprussia.ru>
Date:   Tue, 19 Mar 2019 15:19:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1552994559.4899.26.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 19.03.2019 14:22, Mimi Zohar wrote:
> On Tue, 2019-03-19 at 10:50 +0300, Igor Zhbanov wrote:
>> Hi Mimi,
>>
>> I guess similar to SELinux function:
> [snip]
>=20
> Remember IMA relies on LSMs for mandatory access control(MAC). =C2=A0IM=
A
> measures, audits, and enforces file integrity.

Yes. But LSM will not check integrity of the file mmaped for read. Nor do=
es
IMA.

>> The structure vm_area_struct has a pointer vm_file pointing to mapped =
file
>> so it could be used what file's xattrs to check.
>=20
> That's fine for when there is a file descriptor, but the file
> descriptor could have been closed. =C2=A0(Refer to the mmap manpage.)

Can it be checked?

I think that checking the integrity at least in the case when the file is
still open is better than not checking at all. Because as I said it would
be possible to use mmap+mprotect to bypass IMA for shared libraries check=
ing.
