Return-Path: <SRS0=MdHQ=RR=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B988BC43381
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 22:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D5521019
	for <linux-integrity@archiver.kernel.org>; Thu, 14 Mar 2019 22:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfCNWbu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:31:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbfCNWbt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Mar 2019 18:31:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2EMTY1o125615
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 18:31:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r7vv6yu2q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 14 Mar 2019 18:31:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 14 Mar 2019 22:31:46 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Mar 2019 22:31:44 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2EMVhsP28246154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 22:31:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56BA54C074;
        Thu, 14 Mar 2019 22:31:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88CC84C07F;
        Thu, 14 Mar 2019 22:31:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.108.186])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Mar 2019 22:31:42 +0000 (GMT)
Subject: Re: [RFC] kexec: Allow kexec_file() with appropriate IMA policy
 when locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Thu, 14 Mar 2019 18:31:31 -0400
In-Reply-To: <CACdnJuv=-Gr9Psd1ABZ=fW43-2FHcgEkG_iu0bY20Jx4Vro=mA@mail.gmail.com>
References: <20190312195715.101995-1-matthewgarrett@google.com>
         <1552478316.24794.210.camel@linux.ibm.com>
         <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
         <1552512556.24794.229.camel@linux.ibm.com>
         <CACdnJutmJDLhrdsU9UZtzE+S=Tw39RYqZ3q+TP35PbFbfsL76w@mail.gmail.com>
         <1552525698.24794.237.camel@linux.ibm.com>
         <CACdnJuv=-Gr9Psd1ABZ=fW43-2FHcgEkG_iu0bY20Jx4Vro=mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031422-4275-0000-0000-0000031B1CF0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031422-4276-0000-0000-0000382990CB
Message-Id: <1552602691.8658.49.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903140151
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-03-14 at 14:08 -0700, Matthew Garrett wrote:
> On Wed, Mar 13, 2019 at 6:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > The IMA hash and EVM hmac combination is fine for offline protection.
> > It's used for mutable files.  For immutable files, there must be
> > either an IMA or EVM signature.
> 
> Ok. Is the correct way to handle this to check that the file has a
> signature, or to extend IMA policy to allow it to provide a
> requirement that EVM verify a signature rather than an HMAC and have
> the arch policy set that?

I'm not sure what you mean by "check that the file has a signature".

EVM and IMA are separate subsystems with a defined interface for
interaction between them. evm_verifyxattr() isn't, but could be called
by LSMs.  So evm_verifyxattr() would need to be extended to return the
EVM xattr type.  The IMA policy could then require a specific evmxattr
type.  Possible.

Perhaps for now require IMA signatures and defer supporting EVM
signatures?

Mimi




