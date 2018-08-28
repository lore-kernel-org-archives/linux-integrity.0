Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:45662 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726954AbeH1MXz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Aug 2018 08:23:55 -0400
Received: from pps.filterd (m0048204.ppops.net [127.0.0.1])
        by m0048204.ppops.net-00176a03. (8.16.0.22/8.16.0.22) with SMTP id w7S6bxYF027389
        for <linux-integrity@vger.kernel.org>; Tue, 28 Aug 2018 02:41:06 -0400
From: "Safford, David (GE Global Research, US)" <david.safford@ge.com>
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/2] Support TLV formatted IMA measurement list
Date: Tue, 28 Aug 2018 06:40:59 +0000
Message-ID: <BCA04D5D9A3B764C9B7405BBA4D4A3C002569222@ALPMBAPA12.e2k.ad.ge.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This is an initial RFC patch set to investigate supporting a draft TCG standard for
an attestation measurement list in TLV (Type-Length-Value) binary format.

TLV formatted lists are simple to generate and parse, and flexible for adding
new fields. The primary goal of the patch set is to validate the draft standard
design/specification with working compatible code.

A second goal of the patch set is to test the more radical idea of being able
to copy the measurement list data out of the kernel. The data is verifiable 
with the TPM PCR value, and need not be kept in kernel memory. In some 
cases, this  "memory leak" can grow large enough to cause issues, and this 
is a test of a potential way to solve that problem.

A third goal is to test the idea of using the flexibility of the TLV format to
extend IMA attestation to include additional metadata fields, such as
a file's owner, group, mode, and security labels, the timestamp of the
measurement, and a sequence number, to simplify list management.

Patch 1/2 adds no new features, refactoring the existing template
specific code into separate files, to simplify the addition of TLV support.
Patch 2/2 add the code to support the TLV format.

Feedback is appreciated.
Dave Safford <david.safford@ge.com>
