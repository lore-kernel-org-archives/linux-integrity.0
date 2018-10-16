Return-Path: <SRS0=BjVV=M4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5010CC04EBD
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2E920869
	for <linux-integrity@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2E920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJPTrM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:47:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727002AbeJPTrL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Oct 2018 15:47:11 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GBsj1S119481
        for <linux-integrity@vger.kernel.org>; Tue, 16 Oct 2018 07:57:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n5edhu7nr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Oct 2018 07:57:03 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 16 Oct 2018 12:57:01 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Oct 2018 12:56:58 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9GBuvis4325800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Oct 2018 11:56:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D63F11C05C;
        Tue, 16 Oct 2018 14:56:27 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6DB11C066;
        Tue, 16 Oct 2018 14:56:26 +0100 (BST)
Received: from localhost.localdomain (unknown [9.80.87.57])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Oct 2018 14:56:25 +0100 (BST)
Subject: Re: LPC 2018
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     James Morris <jmorris@namei.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        montywiseman32@gmail.com, serge@hallyn.com, chuck.lever@oracle.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Tue, 16 Oct 2018 07:56:45 -0400
In-Reply-To: <alpine.LRH.2.21.1810160946210.2779@namei.org>
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
         <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
         <20181011154847.GA5978@mail.hallyn.com>
         <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
         <1539296304.3108.54.camel@HansenPartnership.com>
         <alpine.DEB.2.21.1810151652360.28121@jsakkine-mobl1>
         <CACdnJutMR=6OH=DtnAGXkFU+PNae_ONxcQGA7QLPJ9jsBd8j=w@mail.gmail.com>
         <alpine.LRH.2.21.1810160833560.14147@namei.org>
         <1539642523.2867.44.camel@HansenPartnership.com>
         <alpine.LRH.2.21.1810160946210.2779@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101611-0016-0000-0000-00000213B05D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101611-0017-0000-0000-0000326B42D0
Message-Id: <1539691005.11939.258.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160103
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org
Message-ID: <20181016115645.tvgBpJK4eafiu0qjNzKkWMOyO9qd0hY4VlLny5vGy98@z>

On Tue, 2018-10-16 at 09:46 +1100, James Morris wrote:
> On Mon, 15 Oct 2018, James Bottomley wrote:
> 
> > > What about a TPM BoF at LSS
> > 
> > I'm only at LinuxCon/KS, so I'm leaving on Thursday.  I think you have
> > a Wednesday overlap, though, so Wednesday would work.
> 
> LSS is Thurs+Fri, but we may have a quorum for Weds.

Some of us are arriving Wed.  Perhaps try scheduling it later in the
day Wed.

Mimi

