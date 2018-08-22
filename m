Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35021 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbeHVQkb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Aug 2018 12:40:31 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so1387577iob.2
        for <linux-integrity@vger.kernel.org>; Wed, 22 Aug 2018 06:15:39 -0700 (PDT)
MIME-Version: 1.0
From: john HA <john.352618@gmail.com>
Date: Wed, 22 Aug 2018 18:45:38 +0530
Message-ID: <CAO1V6Wrd196kcUiGJYvh9c1b_AmVfhya4hjogxJiyq3WOAoXyQ@mail.gmail.com>
Subject: Excluding UBI partition not working
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Team,

I am writing IMA policy and want to exclude 2 partitions from
appraisal and include 1 partition in appraisal. Policy mentioned below
is not appraising even the partition which I have explicitly marked
for appraisal. I am able to execute unsigned binary freely, no
violation log, no permission denied etc occurs.

dont_measure fsuuid=6266EDB3-0E1B-4D2F-BC75-6CFB7C94E2EF
dont_appraise fsuuid=6266EDB3-0E1B-4D2F-BC75-6CFB7C94E2EF
dont_measure fsuuid=0404D3D8-81E1-4280-9035-175A607C3B0A
dont_appraise fsuuid=0404D3D8-81E1-4280-9035-175A607C3B0A
measure fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC func=BPRM_CHECK
appraise fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC func=BPRM_CHECK
appraise_type=imasig
measure fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC func=FILE_MMAP
appraise fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC func=FILE_MMAP
appraise_type=imasig
measure fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC func=MODULE_CHECK
appraise fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC func=MODULE_CHECK
appraise_type=imasig
measure fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC func=FIRMWARE_CHECK
appraise fsuuid=E62368C8-C03E-4003-8F42-C08E4DC8FEAC
func=FIRMWARE_CHECK appraise_type=imasig

If I changed the policy given below, than appraisal works in all 3 partition.

appraise func=BPRM_CHECK appraise_type=imasig
appraise func=FILE_MMAP appraise_type=imasig
appraise func=MODULE_CHECK appraise_type=imasig
appraise func=FIRMWARE_CHECK appraise_type=imasig

My end goal is: Partition 1 every file (executable/non-executable)
must be appraised. Partition 2,3 nothing should be appraised at all.

What am I doing wrong. Any help please.

-John
