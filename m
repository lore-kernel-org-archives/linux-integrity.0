Return-Path: <SRS0=CrZS=MU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CE2C65C20
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 11:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9F920858
	for <linux-integrity@archiver.kernel.org>; Mon,  8 Oct 2018 11:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9F920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbeJHSy4 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:54:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbeJHSy4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Oct 2018 14:54:56 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98BdX5B130158
        for <linux-integrity@vger.kernel.org>; Mon, 8 Oct 2018 07:43:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n05upa6t4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Oct 2018 07:43:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Oct 2018 12:43:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Oct 2018 12:43:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w98BhUhZ58064922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Oct 2018 11:43:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABB1EAE045;
        Mon,  8 Oct 2018 14:42:16 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A1C1AE057;
        Mon,  8 Oct 2018 14:42:16 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.101.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Oct 2018 14:42:16 +0100 (BST)
Subject: Re: ima_template and ima_template_format - supported and legal
 values
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.vnet.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Date:   Mon, 08 Oct 2018 07:43:19 -0400
In-Reply-To: <e762dedd-17b6-6cb1-837a-4e181f330ca1@linux.vnet.ibm.com>
References: <e762dedd-17b6-6cb1-837a-4e181f330ca1@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18100811-4275-0000-0000-000002C681AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100811-4276-0000-0000-000037D1A784
Message-Id: <1538998999.15382.102.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080116
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181008114319.la5rfElJnm2C4KSkIsuKoNXbS2vhlRwcLKKo2c-WNW0@z>

On Fri, 2018-10-05 at 18:53 -0400, Ken Goldman wrote:
> I have two questions.
> 
> I'm writing an informal specification for the IMA event log.
> 
> I'd like to include a chart noting which kernel version first supported 
> various options.  I.e. the IMA templates (ima, ima-ng, ima-sig), and the
> ima_template_format directive and its various values.

All of this information is readily available in the git repo.  There's
a commit number associated with every line of code.  Use "git blame
<pathname>" to associate a line of code with a specific commit number.

[1] Commit 3323eec921ef ("integrity: IMA as an integrity service
provider")
[2] Commit c2426d2ad502 ("ima: added support for new kernel cmdline
parameter ima_template_fmt")
[3] Commit 3ce1217d6cd5 ("ima: define template fields library and new
helpers")
[4] Commit bcbc9b0cf6d8 ("ima: extend the measurement list to include
the file signature")
[5] Commit 4d7aeee73f53 ("ima: define new template ima-ng and template
fields d-ng and n-ng")

To determine when a commit was upstreamed, add linux-stable as a
remote branch and execute "git branch -r --contains <commit number>".
 In this case, all of the existing template fields and template
formats were upstreamed in Linux 3.13.

linux-2.6:  ima			[1]
linux-3.13: ima-ng		[2, 5]
linux-3.13:
ima-sig		[4]
		
linux-3.13: 'n', 'd'		[3]
linux-3.13: 'n-ng', 'd-ng'	[5]
linux-3.13: 'sig'		[4]


> I'm writing a library of useful IMA event log parsing functions.
> 
> Are all format combinations legal?  It's not enough to look at today's 
> code, because the code can change.
> 
> For example, ima_template_format="sig" doesn't make sense, because
> it's a signature over a missing file data hash, but it's accepted.
> The log it creates is odd, though, with just two entries.

The parser should be able to handle all custom templates, whether or
not it makes sense.  Leaving out the digest (d, d-ng) or the filename
(n, n-ng) also doesn't make sense.  Deciding whether the measurement
list makes sense and/or addressing other measurement list issues, is
left up to userspace applications, such as the attestation server.

Please note that although the old 'd' digest or the 'n' filename
fields are defined, their use should be limited to the 'ima' template.

Mimi

