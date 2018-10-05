Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726737AbeJFFxr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Oct 2018 01:53:47 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w95MnTED026513
        for <linux-integrity@vger.kernel.org>; Fri, 5 Oct 2018 18:52:55 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mxfe7kcsk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 05 Oct 2018 18:52:55 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 5 Oct 2018 18:52:54 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w95MqrZD29753480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-integrity@vger.kernel.org>; Fri, 5 Oct 2018 22:52:53 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DC3512405B
        for <linux-integrity@vger.kernel.org>; Fri,  5 Oct 2018 19:52:45 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52108124055
        for <linux-integrity@vger.kernel.org>; Fri,  5 Oct 2018 19:52:45 -0400 (EDT)
Received: from [9.65.97.109] (unknown [9.65.97.109])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri,  5 Oct 2018 19:52:45 -0400 (EDT)
To: Linux Integrity <linux-integrity@vger.kernel.org>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Subject: ima_template and ima_template_format - supported and legal values
Date: Fri, 5 Oct 2018 18:53:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e762dedd-17b6-6cb1-837a-4e181f330ca1@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I have two questions.

~~

I'm writing an informal specification for the IMA event log.

I'd like to include a chart noting which kernel version first supported 
various options.  I.e. the IMA templates (ima, ima-ng, ima-sig), and the
ima_template_format directive and its various values.

Does anyone have any contribution?

In return, I'll send the document to anyone who asks.

~~

I'm writing a library of useful IMA event log parsing functions.

Are all format combinations legal?  It's not enough to look at today's 
code, because the code can change.

For example, ima_template_format="sig" doesn't make sense, because
it's a signature over a missing file data hash, but it's accepted.
The log it creates is odd, though, with just two entries.
