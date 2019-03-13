Return-Path: <SRS0=IrrW=RQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241AC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 21:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6553820449
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 21:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCMV3Y (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:29:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbfCMV3Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Mar 2019 17:29:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DLNr5L109767
        for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2019 17:29:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r78374s6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2019 17:29:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Mar 2019 21:29:20 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 21:29:18 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DLTHIt55574776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 21:29:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 490215204F;
        Wed, 13 Mar 2019 21:29:17 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B8FAB52051;
        Wed, 13 Mar 2019 21:29:16 +0000 (GMT)
Subject: Re: [RFC] kexec: Allow kexec_file() with appropriate IMA policy
 when locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Wed, 13 Mar 2019 17:29:16 -0400
In-Reply-To: <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
References: <20190312195715.101995-1-matthewgarrett@google.com>
         <1552478316.24794.210.camel@linux.ibm.com>
         <CACdnJuvThFMhGtKT9PYSH-jZD69CBktQNiJmCc=d4PFRbzQvGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031321-0008-0000-0000-000002CC49BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031321-0009-0000-0000-000022386FE8
Message-Id: <1552512556.24794.229.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-03-13 at 13:36 -0700, Matthew Garrett wrote:
> On Wed, Mar 13, 2019 at 4:58 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-03-12 at 12:57 -0700, Matthew Garrett wrote:
> > > Systems in lockdown mode should block the kexec of untrusted kernels.
> > > For x86 and ARM we can ensure that a kernel is trustworthy by validating
> > > a PE signature, but this isn't possible on other architectures. On those
> > > platforms we can use IMA instead, either with native IMA digital
> > > signatures or EVM-protected IMA hashes. Add a function to determine
> > > whether IMA will verify signatures on kexec files, and if so permit
> > > kexec_file() even if the kernel is otherwise locked down. This is
> > > restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set in
> > > order to prevent an attacker from loading additional keys at runtime.
> >
> > Thank you for working on this!  With the changes suggested below, it
> > might work.  :)
> 
> Ok, I'll incorporate them - just one question:
> 
> > > +bool evm_key_loaded(void)
> > >  {
> > >       return (bool)(evm_initialized & EVM_KEY_MASK);
> > >  }
> >
> > This might be sufficient for your environment, but in general it
> > isn't.
> 
> Oh hm. The only case I can see where this isn't sufficient is if the
> filesystem returns EOPNOTSUPP for the EVM xattr, but in that case we
> should already have failed to get the IMA xattr and will fail
> appraisal as a result?

The evm_initialized flag is an indication that EVM has been
initialized on the system.  Both hmac and signatures could be
supported.  Even checking for EVM_INIT_X509 doesn't provide any
guarantees that the particular file has an EVM signature.

(The hmac can be updated (eg. change in security xattrs,
remove/additional of protected xattr), so we can't rely on them.)

> 
> > > +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> >
> > With these defines, the function isn't limited to just "lockdown".
> >  Either fix the defines or the patch description.
> 
> The function will be called even when lockdown isn't enabled, but it
> won't have any impact on the logic flow.

Ok, so inverting the test order should prevent unnecessarily calling
ima_apprase_kexec_signature().

+               if (!ima_appraise_kexec_signature() &&
+                   kernel_is_locked_down(reason)) {

Mimi


