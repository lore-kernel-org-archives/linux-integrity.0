Return-Path: <SRS0=Ndpk=OK=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A099C04EB9
	for <linux-integrity@archiver.kernel.org>; Sat,  1 Dec 2018 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FE920834
	for <linux-integrity@archiver.kernel.org>; Sat,  1 Dec 2018 08:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="WRD0jCue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FE920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLATeM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 1 Dec 2018 14:34:12 -0500
Received: from mout01.posteo.de ([185.67.36.65]:37453 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbeLATeM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Dec 2018 14:34:12 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6223A16005E
        for <linux-integrity@vger.kernel.org>; Sat,  1 Dec 2018 09:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1543652532; bh=JgoKSx+7VyIvdtKVNQkE6dKJMTsWuNP7OCOJPtFjkhs=;
        h=To:From:Subject:Openpgp:Autocrypt:Date:From;
        b=WRD0jCueoI6m1iPoSXBFNTjQ22I1y/Kg6mmOlWSUo3fUG+DWQ1r+YpHeL4wk/pe67
         qCKneFrSmwNUVby3qlVLHf8o5EZhscNFKRMlkzZWA0Up9ZOMYehukkxwWlHCcIGNil
         KoilLirmvLyy9rvXSCV0wlN4hS/AUsXLgEOiVhMoZOW1vCePamDgqiXsZf6bqM0S5B
         59xzkQ6Cup+/dsP0e/8rYf1vzsgoJuLn9zxdKXXV2ZAC3u0jzt4xFjxTnYI7Vk3AbR
         4Hj2mvUKrKwB62td/XXCnoV1uweqqO/k8lUiEBttyAF937mnJVbagmGKfW7+M4JAf1
         JyzRezENMnYWw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 436PPb6CX9z6tm6
        for <linux-integrity@vger.kernel.org>; Sat,  1 Dec 2018 09:22:11 +0100 (CET)
To:     linux-integrity@vger.kernel.org
From:   Malte Gell <malte.gell@posteo.de>
Subject: notebook TPM2 not woking
Openpgp: preference=signencrypt
Autocrypt: addr=malte.gell@posteo.de; prefer-encrypt=mutual; keydata=
 xsBNBFHFZi4BCADXOeOIuQF/W2+SSHleKbQXmp/BboDtxGs4cSqKzMNSFPwFgjmxMjjZLoNG
 GIPn1KGupUEjRlkCaD5v7fAEXSdv9sIr+DIMIr1UB4echez6bHl+nwoSNfHu6+FGHrz5qD5S
 EQROyMVtVyuYdBfeWwPRjN6BIyat4fK+a5kTOGUbdzXtVsCsF7UVh/mNw8jbDiBFSniZ9JJN
 S7RQz1DOBz8xWxtskQF05dC5fpoRnIAftlpMcNhRS6s8eJFnfMQmvIQFf8kfnXIxIPPRmIEA
 x8JS+M8BQ1eGMb4KBq7YW95HIqNVPQp4PK1wMrJhlfimuTO/jFfg8VTgZwCuLWygOH2tABEB
 AAHNIU1hbHRlIEdlbGwgPG1hbHRlLmdlbGxAcG9zdGVvLmRlPsLAfQQTAQMAJwIbAwUJHxbv
 gAQLCgMCBBUDCAIEFgMCAQIeAQIXgAUCWc3X7AIZAQAKCRBZ84E/qM35OKPACACn6FWkup/L
 yt/CTqlcIV7qLsNMG53ptxV2p/v+Xcs/MQMp9xaMN0JfDu5uvEjfu6HHYmTZhUzw4ucPxWW+
 9TsjJQuNp731NUXjBplt7UPDik9WsdGAUSRyDWVJVd/vEuGKFt8rg5geCsTq022lMNXrZg/U
 f6jjtH/t1HT3Rc7iYpN1SO8yxMbw266zwOAuZLECFxI3YYzVmC19fKqA9eW2ldt6kkkyIARl
 PaoObWImOOVv6EDseMSXtQ/l/3S276f/ytLogO+al8+3qINjtKHGSCsjFgVBwE83BIsVFjka
 UgidCu28lFq+iRwaFIgYPYwvH6lVpkDu7ZF1KGdMOE1kzsBNBFHFZi4BCAC7HrQuipr807tu
 R6GbcsxgDX3g/oiiBjAFz+ktkDUm7/4maeymwVJfvpwcfnCGSZePACH5Bd3a/s+otvTQGY2P
 aRFOGymHXQwamRdBfIct9WcqywaUdCf1gaGW5R3MQaSdzQ+b7wpFjDUUg6BhKNH8Nd8RMSfw
 RBo1ZjFU0Ka+NKksx545qS3n2kd2QH+Vk03BRRGYqsRqzLSOBwwBxT+xMJQOpeZabxt8y4Ue
 u8qNRKIoqAc5bxgWlRPsilQgFMkaXAbwc6mrootOBHNZgRHqh7g5GTpJyANHLJDLTIJuQdY5
 8m1TBSB6vEPqt/wdyGQIN76WQ66u2934dM1k/8UbABEBAAHCwGUEGAEDAA8FAlHFZi4CGwwF
 CR8W74AACgkQWfOBP6jN+ThjgAgAgR2X+1Vuzz03o7N9NpYgLogfHne8RYz9QAZX4629mdXD
 q0KPqZQLYN1WnLvHanzhYKjzvLwwpzLgxie2xx/tlOuuZceOTLc3aEIxWpG3rt0teTddLzgC
 2Po7ls+DT/cKbg4k9y6A1YbHFUkasvE0tmcLFSoMx7cDtoCdTRvpVpHIixHuv6Q/PHvcITIR
 hhxELMG3p/b7szdb1srydIaai1k8GBIAWgjbxNPN96io706bYAtZjOQB03M345/Zbb3xqSV0
 AmGA7QYO2nglVi1Su/1PgTKwSNzGCpg6nfI5Ma5F318S/rOdtNjcN6vrSBdxwVBvQz4Pd4Ar
 x4QX/ZVjdQ==
Message-ID: <783c85b4-0ccd-23a2-be57-fd08eab13a50@malte.gell.posteo.de>
Date:   Sat, 1 Dec 2018 09:22:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi there,

I have an Acer notebook "Siwft 3", AMD Ryzen platform that does not
enable the TPM2 chip with Linux.

Precise model name is SF315-41-R4W1 with current UEFI bios, current
kernel I use is 4.19.4.

dmesg | grep -i tpm says this:

efi:  ACPI 2.0=0x8f7fe014  ESRT=0x8c4be298  SMBIOS=0x8c4b9000  SMBIOS
3.0=0x8c4b7000  MEMATTR=0x89355018  TPMEventLog=0x826b6018
[    0.005953] ACPI: TPM2 0x000000008F7C1000 000034 (v04 ACRSYS ACRPRDCT
00000002 1025 00040000)
[    3.856038] tpm_crb MSFT0101:00: can't request region for resource
[mem 0x8f775000-0x8f778fff]
[    3.856070] tpm_crb: probe of MSFT0101:00 failed with error -16
[    4.218481] ima: No TPM chip found, activating TPM-bypass!

TPM is of course enabled in bios. I have already tried to clear the TPM
and reboot with no success.


If you need ACPI dump and IOMEM data to help debugging, I have uploaded
them to a file hoster:


acpidump.log      md5   498d199ec422b7d2a450ee13ecfaf6a5

https://www.file-upload.net/download-13412947/acpidump.log.html


iomem.log    md5    2afe196e407c3b9bb33fdc54871d8475

https://www.file-upload.net/download-13412948/iomem.log.html


I´m glad for any advise how to get thad damn thing working.
My main purpose of TPMs is to use the integrated hardware RNG.

thanks
Malte
