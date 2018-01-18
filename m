Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932473AbeARWbW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jan 2018 17:31:22 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0IMSlq7084410
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jan 2018 17:31:22 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2fk3hy24fy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jan 2018 17:31:21 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 18 Jan 2018 22:31:19 -0000
Subject: [GIT PULL] IMA bug fix for 4.16
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Thu, 18 Jan 2018 17:31:16 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516314676.3772.20.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi James,

Sorry, here's one last patch for 4.16.

thanks,

Mimi

---
 
The following changes since commit a2a2c3c8580a9158bca61221648fd6d5c98c443a:

  ima: Use i_version only when filesystem supports it (2017-12-18 09:43:49 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to 36447456e1cca853188505f2a964dbbeacfc7a7a:

  ima/policy: fix parsing of fsuuid (2018-01-18 16:52:49 -0500)

----------------------------------------------------------------
Mike Rapoport (1):
      ima/policy: fix parsing of fsuuid

 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
