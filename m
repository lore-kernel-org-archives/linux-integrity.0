Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:54588 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbeCTUdp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Mar 2018 16:33:45 -0400
Received: by mail-wm0-f46.google.com with SMTP id h76so5948874wme.4
        for <linux-integrity@vger.kernel.org>; Tue, 20 Mar 2018 13:33:45 -0700 (PDT)
MIME-Version: 1.0
From: Martin Galvan <omgalvan.86@gmail.com>
Date: Tue, 20 Mar 2018 17:33:23 -0300
Message-ID: <CAN19L9FM+Lf=jANLjjZiiOB=ztVvh_fGTo1iDT01fX1_UFJJ6w@mail.gmail.com>
Subject: Reading from /sys/class/tpm/tpmX/device/pcrs
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi all,

Documentation/ABI/stable/sysfs-class-tpm says the following about
/sys/class/tpm/tpmX/device/pcrs:

"The "pcrs" property will dump the current value of all Platform
Configuration Registers in the TPM. Note that since these values may
be constantly changing, the output is only valid for a snapshot in
time."

Does this mean that if I read this file line-by-line through a
stream-like API (such as std::ifstream) I could potentially end up
with reg values from different moments in time? E.g. the PCR-00 value
will correspond to time T0, PCR-01 will correspond to time T1, end so
on.

Would it be safer to make a copy of the file first, or could this have
the same issue?
