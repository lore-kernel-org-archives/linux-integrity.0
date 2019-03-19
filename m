Return-Path: <SRS0=sVEj=RW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936D8C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBA220989
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 07:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omprussia.ru header.i=@omprussia.ru header.b="J1deNDNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfCSHub (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:50:31 -0400
Received: from mail.omprussia.ru ([5.134.221.218]:50776 "EHLO
        mail.omprussia.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSHub (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Mar 2019 03:50:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id A18A5B5454A;
        Tue, 19 Mar 2019 10:50:29 +0300 (MSK)
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3AkWgq_wzifn; Tue, 19 Mar 2019 10:50:29 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.omprussia.ru (Postfix) with ESMTP id 3DB08B54550;
        Tue, 19 Mar 2019 10:50:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.omprussia.ru 3DB08B54550
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omprussia.ru;
        s=EC9C64F2-3532-11E8-B653-5B7E995A80AF; t=1552981829;
        bh=A+UZLvK4OtME4ZVEcBhaeosJPowqiU1j93RJWqC30s8=;
        h=To:From:Message-ID:Date:MIME-Version;
        b=J1deNDNqPlb+1mfQNnrWUwMxa8vBbOBsNfd8IFDWxPgN9YFGn9D2lKkK5DEPupIrJ
         RokYD7zXw3aIKgU0CDTlysTsPohf+5kKuRNFsprQh4+DFzkFIF/Ygx9LohoYkW5VIP
         HiGEQkWWwb3zts5+bHDTfWtaKUoGxdTlCP91wsNQKf67pg6Th0/DaDdZu7V4nJCzUk
         hJeYQYTuVBkKlmVSLrO0afPv3Lpd4isqzA/ivsp5VeEvDBTXk7pzll5QFoUQsjmDOs
         ZqS/5pvDuacBwdPPwS6qQmNNOqc0Tml8w4OKJHa4Gg/LiUo2rWRDZ08daH00DoZq8s
         YVXuCnIPnXLtg==
X-Virus-Scanned: amavisd-new at mail.omprussia.ru
Received: from mail.omprussia.ru ([127.0.0.1])
        by localhost (mail.omprussia.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TOxPtcMiUnFA; Tue, 19 Mar 2019 10:50:29 +0300 (MSK)
Received: from [10.189.20.33] (unknown [10.189.20.33])
        by mail.omprussia.ru (Postfix) with ESMTPSA id 08C35B5454A;
        Tue, 19 Mar 2019 10:50:29 +0300 (MSK)
Subject: Re: Should mprotect(..., PROT_EXEC) be checked by IMA?
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <cce2c4c7-5333-41c3-aeef-34d43e63acb0@omprussia.ru>
 <1552945715.8658.299.camel@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omprussia.ru>
Message-ID: <452752df-98f9-c361-878a-5df84ab36847@omprussia.ru>
Date:   Tue, 19 Mar 2019 10:50:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1552945715.8658.299.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

I guess similar to SELinux function:
---8<--------------------------------------------------------------------=
----
static int selinux_file_mprotect(struct vm_area_struct *vma,
                                  unsigned long reqprot,
                                  unsigned long prot)
{
         const struct cred *cred =3D current_cred();
         u32 sid =3D cred_sid(cred);

         if (selinux_state.checkreqprot)
                 prot =3D reqprot;

         if (default_noexec &&
             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
                 int rc =3D 0;
                 if (vma->vm_start >=3D vma->vm_mm->start_brk &&
                     vma->vm_end <=3D vma->vm_mm->brk) {
                         rc =3D avc_has_perm(&selinux_state,
                                           sid, sid, SECCLASS_PROCESS,
                                           PROCESS__EXECHEAP, NULL);
                 } else if (!vma->vm_file &&
                            ((vma->vm_start <=3D vma->vm_mm->start_stack =
&&
                              vma->vm_end >=3D vma->vm_mm->start_stack) |=
|
                             vma_is_stack_for_current(vma))) {
                         rc =3D avc_has_perm(&selinux_state,
                                           sid, sid, SECCLASS_PROCESS,
                                           PROCESS__EXECSTACK, NULL);
                 } else if (vma->vm_file && vma->anon_vma) {
                         /*
                          * We are making executable a file mapping that =
has
                          * had some COW done. Since pages might have bee=
n
                          * written, check ability to execute the possibl=
y
                          * modified content.  This typically should only
                          * occur for text relocations.
                          */
                         rc =3D file_has_perm(cred, vma->vm_file, FILE__E=
XECMOD);
                 }
                 if (rc)
                         return rc;
         }

         return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_=
SHARED);
}
---8<--------------------------------------------------------------------=
----

The structure vm_area_struct has a pointer vm_file pointing to mapped fil=
e
so it could be used what file's xattrs to check.

Thanks.

On 19.03.2019 0:48, Mimi Zohar wrote:
> On Mon, 2019-03-18 at 18:18 +0300, Igor Zhbanov wrote:
>> Hello!
>>
>> I've found that IMA checks for executable mmap()s but not for the
>> combination of mmap(..., PROT_READ, ...) + mprotect(..., PROT_EXEC).
>>
>> So it looks like is possible to load arbitrary executable code
>> by rewriting dlopen() and dlsym() functions to map all ELF segments
>> read-only first then making them executable with mprotect().
>>
>> So should security_file_mprotect() be changed similarly
>> to security_mmap_file() to call IMA security hook?
>=20
> How? =C2=A0security_mmap_file() is passed a file descriptor and the sig=
nature,
> stored as an xattr, can be verified.
>=20
> Mimi

--=20
=D0=98=D0=B3=D0=BE=D1=80=D1=8C =D0=96=D0=B1=D0=B0=D0=BD=D0=BE=D0=B2
=D0=B7=D0=B0=D0=BC. =D1=82=D0=B5=D1=85. =D0=B4=D0=B8=D1=80=D0=B5=D0=BA=D1=
=82=D0=BE=D1=80=D0=B0 =D0=BF=D0=BE =D1=82=D0=B5=D1=85=D0=BD=D0=BE=D0=BB=D0=
=BE=D0=B3=D0=B8=D1=8F=D0=BC
=D0=9E=D0=9E=D0=9E =C2=AB=D0=9E=D1=82=D0=BA=D1=80=D1=8B=D1=82=D0=B0=D1=8F=
 =D0=BC=D0=BE=D0=B1=D0=B8=D0=BB=D1=8C=D0=BD=D0=B0=D1=8F =D0=BF=D0=BB=D0=B0=
=D1=82=D1=84=D0=BE=D1=80=D0=BC=D0=B0=C2=BB
=D0=A2=D0=B5=D0=BB.: +7 495 269-07-79, =D0=B4=D0=BE=D0=B1. 606
=D0=9C=D0=BE=D0=B1.: +7 903 001-98-55
E-mail: i.zhbanov@omprussia.ru
