Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751286AbeCVQUk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 12:20:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2MGKUV4040797
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 12:20:39 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gvergv7sp-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 22 Mar 2018 12:20:38 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 22 Mar 2018 12:20:37 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: A subtle problem when resuming xen-front and using IMA and multiple
 TPM devices on the system
To: linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 22 Mar 2018 12:20:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <28f8dc8a-cfa3-376a-5e6a-98d79418e3d1@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I tried to convert the IMA code to look up a TPM chip and use it until 
shutdown, when it releases it before device_shutdown(). Ideally this 
would work but because of xen-front's resume code it doesn't. There the 
chip is unregistered upon domU resume (tpmfront_resume calls 
tpmfron_remove) and for that reason IMA cannot be holding onto that chip 
until shutdown. Now the subtle problem comes into play when we were to 
use tpm_vtpm_proxy (with IMA namespaces for example some day) inside a 
domU that is resumed. Upon resume the domU looses its first chip, which 
would be the vTPM accessed via xen-front. IMA now uses 
tpm_pcr_extrend(NULL, ...) to extend a PCR and looks up the first chip 
due to the NULL parameter and now finds a tpm_vtpm_proxy's chip to 
extend the PCR into and this messes up the PCR. So that's bad and only 
in this particular configuration.

Due to how the xen-front works, the solution may be to:
- return -ENODEV from any public TPM API functions in case NULL is being 
passed as chip parameter; do not look up the chip, it will not return 
the one that was there before domU resume
- all subsystems that want to use a TPM have to look it up at the very 
beginning when there is only a hardware TPM there or the domU TPM
    - all these subsystems (looks like IMA and trusted keys) have to 
register a xen-release-tpm-device notifier that is invoked upon 
xen-front resume and causes the subsystems to release the device; upon 
domU resume these subsystems loose their TPM access

Another solution may be to introduce some flags that describe the chips 
and tpm_chip_find_get() would take these flags and check whether a chip 
has these flags set so that IMA and trusted keys wouldn't use a 
tpm_vtpm_proxy in that case.

Comments?

    Stefan
