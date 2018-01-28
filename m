Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752198AbeA1TBz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 28 Jan 2018 14:01:55 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0SIx0sJ089339
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2018 14:01:55 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fs78nu1t6-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 28 Jan 2018 14:01:55 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 28 Jan 2018 19:01:53 -0000
Subject: Re: [PATCH 00/10] ima-evm-utils
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sun, 28 Jan 2018 14:01:48 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1517166108.29187.284.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-01-22 at 09:53 -0500, Mimi Zohar wrote:
> Before upgrading to the new OpenSSL 1.1 API, let's clean up the code
> a bit and add some missing functionality:
> - option to specify the pcr sysfs location
> - verify the measurement list using multiple keys
> - verify the measurement list using multiple pcrs
> - verify a measurement signature against the measurement list digest
> - for completeness, extend "ima_verify" to verify the local security.ima hash

With James' "ima-evm-utils: Add backward compatible support for
openssl 1.1" patch, which supports both OpenSSL 1.0 and 1.1, there is
no rush for including all these changes now.

For example instead of specifying the pcr sysfs location, a better
solution would be for the TPM device driver to export this
information.

The next branch contains the proposed changes for ima-evm-utils
version 1.1, which I'm hoping to release within the next day or so.

thanks,

Mimi

 
