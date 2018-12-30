Return-Path: <SRS0=h2tl=PH=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5F1C43387
	for <linux-integrity@archiver.kernel.org>; Sun, 30 Dec 2018 04:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEB82173B
	for <linux-integrity@archiver.kernel.org>; Sun, 30 Dec 2018 04:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeL3ETd (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 29 Dec 2018 23:19:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbeL3ETd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 29 Dec 2018 23:19:33 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBU4Ixhk099026
        for <linux-integrity@vger.kernel.org>; Sat, 29 Dec 2018 23:19:32 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pp54bta19-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 29 Dec 2018 23:19:32 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 30 Dec 2018 04:19:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 30 Dec 2018 04:19:27 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBU4JQKj8782088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Dec 2018 04:19:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51EE05204E;
        Sun, 30 Dec 2018 04:19:26 +0000 (GMT)
Received: from unknown4C3488A63DDA (unknown [9.80.105.198])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2800452051;
        Sun, 30 Dec 2018 04:19:24 +0000 (GMT)
Subject: Re: [DISCUSSION] IMA measurement log format
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jordan Hand <Jordan.Hand@microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        David Safford <david.safford@ge.com>
Date:   Sat, 29 Dec 2018 23:19:13 -0500
In-Reply-To: <CY4PR21MB06311ED50B5A02F94AF307B0F0B70@CY4PR21MB0631.namprd21.prod.outlook.com>
References: <CY4PR21MB06311ED50B5A02F94AF307B0F0B70@CY4PR21MB0631.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18123004-0020-0000-0000-000002FDDFFE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123004-0021-0000-0000-0000214E1780
Message-Id: <1546143553.4069.110.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812300040
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Monty Wiseman and David Safford)

Hi Jordan,

On Fri, 2018-12-28 at 19:25 +0000, Jordan Hand wrote:
> Hi folks,
> 
> I have a question about the format of the IMA measurement log
> (/sys/kernel/security/ima/binary_runtime_measurements).
> 
> The current IMA format uses the following structure:
> 
> struct ima_template_entry {
> 	int pcr;
> 	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
> 	struct ima_template_desc *template_desc; /* template descriptor */
> 	u32 template_data_len;
> 	struct ima_field_data template_data[0];	/* template related data */
> };
> 
> My question is, why does the IMA log not use the same log format
> that is used for PCR events in the TCG EFI spec? This would allow
> the same parser to be used for binary_bios_measurements and
> binary_runtime_measurements, while still maintaining all information
> captured by the current template format simply as event data.
> 
> Here is the EFI structure that is logged for each event in
> binary_bios_measurements (it is similar the structure used by IMA
> but different enough to require different parsing).
> 
> typedef struct {
>     TCG_PCRINDEX PCRIndex;
>     TCG_EVENTTYPE EventType;
>     TCG_DIGEST digest;
>     UINT32 EventSize;
>     UINT8 Event[1];
> } TCG_PCR_EVENT;
> 
> From the TCG EFI Spec: https://trustedcomputinggroup.org/wp-content/
> uploads/EFI-Protocol-Specification-rev13-160330final.pdf
> Note the above structure is for the TPM1.2 speficiation. There is a
> slightly different crypto-agile TCG_PCR_EVENT2 structure for
> TPM2.0. 
> 
> I feel that, when possible, it is best that the kernel keep
> continuity with other components which will be measuring events into
> the TPM for ease of parsing when these logs are used for
> attestation.
> 
> I understand these may not be trivial changes (and log format
> changes may break existing applications) but I would like to get
> some thoughts on why some of these decisions were made and possible
> ways to get more continuity in Linux system attestation moving
> forward.

Although IMA was only upstreamed in 2009, some of the code dates back
to the early 2000's.  The first paper "Design and implementation of a
TCG-based integrity measurement architecture" was published in Usenix
2004.

You should probably look at Monty Wiseman's and David Safford's LSS-NA 
2018 talk titled "A Canonical Event Log Structure for IMA".  Slides
and recordings of LSS-NA 2018 can be found on the LF website.

Defining a new log format is definitely non trivial and may not break
existing userspace applications.

Mimi

